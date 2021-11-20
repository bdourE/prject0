//
//  File.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
struct Type : Codable {
    var id : Int
    var arabicName : String
    var englishName : String
    var subTypes : [SubType]
}

struct SubType : Codable {
    var id : Int
    var arabicName : String
    var englishName : String
    var categoryId : Int
}
