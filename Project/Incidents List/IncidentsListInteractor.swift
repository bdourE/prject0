//
//  IncidentsListInteractor.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import UIKit

protocol IncidentsListRoutable {
    func goToIncidintsPage()
    func goToFiltersPage()
}

final class IncidentsListInteractor: IncidentsListInteractable {

    private let router: IncidentsListRoutable
    private let worker: IncidentsListWorkable
    init(worker: IncidentsListWorkable,router: IncidentsListRoutable) {
        self.router = router
        self.worker = worker
    }

    func getIncidentsList(_ reqResponse: @escaping ([Incident]) -> Void){
        worker.getIncidentsList { incidents in
            reqResponse(incidents)
        }
    }

    func goToFiltersPage(){
        router.goToFiltersPage()
    }
}


