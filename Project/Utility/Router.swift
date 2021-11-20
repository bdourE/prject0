//
//  Router.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//


import UIKit


final class Router: LoginRoutable, IncidentsListRoutable , FiltersRoutable {

    private let navigationController: UINavigationController
    let userManager = UserManager.shared


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goLoginController() {
        let vc = LoginSceneComposer.makeScene(worker: userManager, router: self)
        present(viewController: vc)
    }

    func goToIncidintsPage() {
        let vc = IncidentsListSceneComposer.makeScene(router: self)
        present(viewController: vc)
    }

    func goToFiltersPage() {
        let vc = FiltersTableController(router: self)
        present(viewController: vc)
    }

    func goToList(choosenFilters: [Int]) {

    }

    func goToDashboardTapped(){
        let vc = DashboardViewController()
        present(viewController: vc)
    }

    private func present(viewController: UIViewController) {
        navigationController.navigationBar.topItem?.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }

    func endFlow() {
            navigationController.dismiss(animated: true, completion: nil)
    }
}
