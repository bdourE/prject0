//
//  FilterTableViewCell.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import UIKit
import Foundation
final class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!

    func setContent(name: String){
        label1.text = name
        if isSelected {
            backgroundColor = .purple
        }
    }

}
