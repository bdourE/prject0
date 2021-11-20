//
//  IncidentsListSceneComposer.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import UIKit
enum IncidentsListSceneComposer {

    static func makeScene(router: IncidentsListRoutable) -> UIViewController {
        let worker = IncidentsListWorker()
        let interactor = IncidentsListInteractor(worker: worker, router: router)
        return IncidentsListViewController(interactor: interactor)
    }
}
