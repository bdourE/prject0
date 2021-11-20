//
//  NetworkM.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import Sentry

typealias Response<T> = (_ result: AFResult<T>) -> Void

extension NetworkManager {

    func almofireErrors(error: AFError)->(errorMessege:String, statusCode:Int){
        var statusCode = 0
        var errorMessege = "No Messege"
        statusCode = error._code // statusCode private
        switch error {
        case .invalidURL(let url):
            errorMessege = "Invalid URL: \(url) - \(error.localizedDescription)"
        case .parameterEncodingFailed(let reason):
            errorMessege = "Parameter encoding failed: \(error.localizedDescription) /n Failure Reason: \(reason)"
        case .multipartEncodingFailed(let reason):
            errorMessege = "Multipart encoding failed: \(error.localizedDescription) /n Failure Reason: \(reason)"
        case .responseValidationFailed(let reason):
            errorMessege = "Response validation failed: \(error.localizedDescription) /n Failure Reason: \(reason)"
                            switch reason {
                            case .dataFileNil, .dataFileReadFailed:
                                errorMessege = "Downloaded file could not be read"
                            case .missingContentType(let acceptableContentTypes):
                                errorMessege = "Content Type Missing: \(acceptableContentTypes)"
                            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                                errorMessege = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                            case .unacceptableStatusCode(let code):
                                errorMessege = "Response status code was unacceptable: \(code)"
                                statusCode = code
                            case .customValidationFailed(error: let error):
                                errorMessege = error.localizedDescription
                        default:break
                        }
        default:break
        }

        return (errorMessege , statusCode)
    }

    func reportSentryError(errorMessage: JSON?,errorMessageString: String = "", errorCode: Int, fullUrl: String, payload: String?,action: APIAction){
            if let evenTitle = getSentryEventMessge(action: action) {
                let errorMessage = errorMessage?["error"].string ?? errorMessageString
                let event = Event()
                #if STAGING
                event.environment = "Staging"
                #elseif TEST
                event.environment = "test"
                #else
                event.environment = "production"
                #endif
                event.level = .info
                event.tags = ["ErrorCode": String(errorCode)]
                event.message = SentryMessage(formatted: "API Error : " + evenTitle)
                event.extra = getSentryExtras(errorMessage: errorMessage, errorCode: errorCode, url: fullUrl , payload: payload ?? "")
                SentrySDK.capture(event: event)
            }}

    func getSentryExtras(errorMessage: String, errorCode: Int, url: String, payload: String) -> [String: Any] {
        var extra: [String: Any] = [:]
        if !payload.isEmpty {
            extra["request"] = payload
        }
        if !url.isEmpty {
            extra["url"] = url
        }

        if !errorMessage.isEmpty {
            extra["errorMessage"] = errorMessage
        }
        extra["errorCode"] = errorCode
        return extra
    }

    func getSentryEventMessge(action: APIAction)-> String?{
        let route = APIRouter.to(action, selector: "")
        var messege: String?
        if let url = URL(string: route.full_url) {
              messege = String(url.path.dropFirst())
        }
        return messege
    }

    func checkingErrorType(errorMessage: JSON?, errorCode: Int, fullUrl: String, payload: String?,action: APIAction){
        if errorCode != 200 && errorCode != 201 {
                #if !DEBUG
           // reportSentryError(errorMessage: errorMessage, errorCode: errorCode, fullUrl: fullUrl, payload: payload, action: action)
                #endif
        }
    }
}
