//
//  LoginInteractor.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import UIKit

protocol LoginRoutable {
    func goToIncidintsPage()
    func goToDashboardTapped()

}

final class LoginInteractor: LoginInteractable {

    private let router: LoginRoutable
    private let worker: LoginWorkable
    init(worker: LoginWorkable,router: LoginRoutable) {
        self.router = router
        self.worker = worker
    }


    func login(email: String, _ reqResponse: @escaping (Bool) -> Void) {
        worker.login(email: email) { success in
            if success == 200 {
                reqResponse(true)
            } else {
                reqResponse(false)
            }
        }
    }

    func varifyOTP(email: String, otp: String, _ reqResponse: @escaping (Bool) -> Void) {
        worker.varifyOTP(email: email, otp: otp) { success in
            if success == 200 {
                self.router.goToIncidintsPage()
            }
            reqResponse(success == 200 ? true : false)
        }
    }

    func goToIncidintsPage() {
        router.goToIncidintsPage()
    }
    func showDashboardTapped(){
        router.goToDashboardTapped()
    }
}
