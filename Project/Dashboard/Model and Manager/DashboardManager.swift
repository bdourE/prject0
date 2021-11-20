//
//  IncidentManager.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import  SwiftyJSON

class DashboardManager {
    let networkManager = NetworkManager.sharedInstance

    init() {}
    func getValues(_ reqResponse: @escaping ([Value]) -> Void){
        networkManager.loadData(.getDashboardValues, auth_token: nil, reqResponse: { data, code in
            if code == 200 , let data = data {
                reqResponse(self.parsData(data: data["incidents"].array ?? []))
            }
        })
    }

    func parsData(data:[JSON])->[Value]{
    var values = [Value]()
        for item in data {
            let value = Value(id: item["status"].int ?? -1, count: item["_count"]["status"].int ?? -1 )
            values.append(value)
        }
        return values
    }
}
