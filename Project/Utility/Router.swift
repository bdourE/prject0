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
        let vc = IncidentsListSceneComposer.makeScene(router: self)
        present(viewController: vc)
    }

    func goToDashboardTapped(){
        let vc = DashboardViewController()
        present(viewController: vc)
    }

    @objc func goToSubmitIncedint(){
        let worker = IncidentsListWorker()
        let vc = SubmitInsidentsViewController(worker: worker)
        navigationController.definesPresentationContext = true
        vc.modalPresentationStyle = .overCurrentContext
        navigationController.present(vc, animated: true, completion: nil)
    }

    private func present(viewController: UIViewController) {
        if viewController.isKind(of: IncidentsListViewController.self) {
           let Submit = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(goToSubmitIncedint))
            viewController.navigationItem.rightBarButtonItem = Submit
        }
        navigationController.navigationBar.topItem?.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }

    func endFlow() {
            navigationController.dismiss(animated: true, completion: nil)
    }


}
