//
//  Action.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import Alamofire

enum APIAction {
    case login, varifyOTP, getIncidents,getFilters,getDashboardValues, submitIncident
}

enum RequestsMethods {
    case get, post
}

enum APIRouter {

    static let base_url = "https://842c3c40-c8a4-492e-97ff-efe695121444.mock.pstmn.io/"


    static func baseUrl () -> String {
        return base_url
    }

    static func to(_ route: APIAction, selector: String) -> (method: HTTPMethod, full_url: String) {
        //let selectorUTF: String = selector.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        switch route {
        case .login:
            return (HTTPMethod.post, base_url + "/login")

        case .varifyOTP:
            return (HTTPMethod.post, base_url + "/verify-otp")
        case .getIncidents:
            return (HTTPMethod.get, base_url + "/incident")
        case .getFilters:
            return (HTTPMethod.get, base_url + "/types")
        case .getDashboardValues:
            return (HTTPMethod.get, base_url + "/dashboard")
        case .submitIncident:
            return (HTTPMethod.post, base_url + "/incident")
        }
    }
}

