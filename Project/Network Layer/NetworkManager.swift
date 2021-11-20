//
//  NetworkManager.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import SwiftyJSON
import Alamofire
import Sentry

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

final class NetworkManager {

    static let sharedInstance = NetworkManager()


    func loadData(_ action: APIAction, selector: String? = "", auth_token: String?, bodyParameters: [String: AnyObject]? = nil, reqResponse: @escaping (_ json: JSON?, _ statusCode: Int?) -> Void) {
        let route: (method: Alamofire.HTTPMethod, full_url: String)
        if let selectorNumber = selector {
            route = APIRouter.to(action, selector: selectorNumber)
        } else {
            route = APIRouter.to(action, selector: "")
        }

        var headers: HTTPHeaders = [:]

        if let token = auth_token {
            headers["Authorization"] = "bearer \(token)"
        }
   //     headers["api-version"] = "2021-09-01"

        if Connectivity.isConnectedToInternet() {
            AF.request(route.full_url, method: route.method, parameters: bodyParameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if let statusCode = response.response?.statusCode {
                   if statusCode == 200 {

                    self.checkingErrorType(errorMessage: JSON(response.error), errorCode: statusCode, fullUrl: route.full_url, payload: bodyParameters?.debugDescription, action: action)

                    reqResponse(JSON(response.data), statusCode)

                } else {
                    self.checkingErrorType(errorMessage: JSON(response.error), errorCode: statusCode, fullUrl: route.full_url, payload: bodyParameters?.debugDescription, action: action)
                    reqResponse(nil, statusCode)
                }
                } else {
                    reqResponse(nil, -1009)
                } } } else {
            print("No internet connection")
        }
    }

}
