//
//  InitialViewController.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        initiatApp()
    }

    func initiatApp() {
        let navController = UINavigationController()
        let router = Router(navigationController: navController)
        router.goLoginController()
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }

}

