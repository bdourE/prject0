//
//  IncidentsListWorker.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import SwiftyJSON

import Foundation
protocol IncidentsListWorkable {
    func getIncidentsList(_ reqResponse: @escaping ([Incident]) -> Void)
}

final class IncidentsListWorker: IncidentsListWorkable {

    private let networkManager = NetworkManager.sharedInstance

    init() {}

    func getIncidentsList(_ reqResponse: @escaping ([Incident]) -> Void){
        networkManager.loadData(.getIncidents, auth_token: nil) { reponse, status in
            if status == 200 , let reponse = reponse{
                do {
                    let data = try? reponse["incidents"].rawData()
                    let decoder = JSONDecoder()
                    let incident = try decoder.decode([Incident].self, from: data as! Data)
                    reqResponse(incident)
                } catch {
                    print("error:\(error)")
                }
            }}
    }

}
