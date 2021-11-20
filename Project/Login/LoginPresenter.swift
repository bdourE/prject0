//
//  LoginPresenter.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation

enum LoginPresenter {

    static func viewModel() -> LoginViewModel {

        return LoginViewModel(loginText: "Login", enterEmailText: "please enter your email", enterOTPText: "please enter otp", loginButtonText: "login", varifyButtonText: "varify")
    }
}
