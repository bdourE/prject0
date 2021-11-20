//
//  Incident.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.

import Foundation

struct Incident : Codable {

    var id : String
    var description : String
    var latitude : Double
    var longitude : Double
    var status : Int
    var priority : Int?
    var typeId : Int
    var issuerId : String
    var assigneeId : String?
    var createdAt : String
    var updatedAt : String
    var medias : [Media]
}

struct Media : Codable {
    var id : String
    var mimeType : String
    var url : String
    var type : Int
    var incidentId : String
}

