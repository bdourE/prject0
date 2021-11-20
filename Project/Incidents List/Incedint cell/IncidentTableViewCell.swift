//
//  File.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import UIKit
final class IncidentTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!


    func setContent(incedint:Incident){
        label1.text = "Incedint id: " + incedint.id
        label2.text = "description: " + incedint.description
        label3.text = "creation data: " + incedint.createdAt
        label4.text = "status: " + String(incedint.status)
    }
}
