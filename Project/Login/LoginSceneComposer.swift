//
//  LoginSceneComposer.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//
import UIKit

enum LoginSceneComposer {

    static func makeScene(worker: LoginWorkable ,router: LoginRoutable) -> UIViewController {
        let interactor = LoginInteractor(worker: worker, router: router)
        let viewModel = LoginPresenter.viewModel()
        return LoginViewController(interactor: interactor, viewModel: viewModel)
    }
}
