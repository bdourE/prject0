//
//  File.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import SwiftyJSON

struct User {
    var email: String?
    var token: String?
    var roles: [Int]?
}

protocol LoginWorkable {
    func login(email: String, _ reqResponse: @escaping (_ statusCode: Int?) -> Void)
    func varifyOTP(email: String, otp: String, _ reqResponse: @escaping (_ statusCode: Int?) -> Void)

}

final class UserManager : LoginWorkable {

    static let shared = UserManager()
    let networkManger = NetworkManager.sharedInstance
    var user = User()

    func login(email: String, _ reqResponse: @escaping (_ statusCode: Int?) -> Void) {
        let params = [
            "email": email,
        ] as [String: AnyObject]?

        networkManger.loadData(.login, selector: nil, auth_token: nil, bodyParameters: params) { [self] json, statusCode -> Void in
            if statusCode == 200 {
                reqResponse(statusCode)
            } else {
                reqResponse(statusCode)

            }
        }
    }

    func varifyOTP(email: String,otp: String, _ reqResponse: @escaping (_ statusCode: Int?) -> Void) {
        let params = [
            "email": email,
            "otp": otp,
        ] as [String: AnyObject]?

        networkManger.loadData(.varifyOTP, selector: nil, auth_token: nil, bodyParameters: params) { [self] json, statusCode -> Void in

            if statusCode == 200 , let response = json {
                parseUser(email: email, data: response)
                reqResponse(statusCode)
            } else {
                reqResponse(statusCode) }
        }
    }

    func parseUser(email:String,data:JSON){
        user.email = email
        user.token = data["token"].string
        user.roles = data["roles"].arrayObject as? [Int]
    }


}

