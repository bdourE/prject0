//
//  UITableview+Extensions.swift
//  toDoorstep
//
//  Created by Anderson Costa on 08/12/2020.
//  Copyright © 2020 toDoorstep. All rights reserved.
//

import UIKit

extension UITableView {

    /**
     * Registers an UITableViewCell for reuse using  a nib  file
     * - Parameter cellType: The Swift file to use with the cell
     * - Parameter nibName: The XIB file name if different from the Swift file name.
     * Defaults to the string value of the cellType
     * - Parameter reuseIdentifier: The identifier used to dequeue the cell.
     * Defaults to the string value of the cellType
     */
    func registerNibCell<T: UITableViewCell>(ofType cellType: T.Type, nibName: String? = nil, reuseIdentifier: String? = nil) {
        let cellName = String(describing: cellType)
        let nib = UINib(nibName: nibName ?? cellName, bundle: Bundle(for: cellType))
        register(nib, forCellReuseIdentifier: reuseIdentifier ?? cellName)
    }

    /**
     * Registers an UIView for reuse as a section header using  a nib  file
     * - Parameter headerType: The Swift file to use with the view
     * - Parameter nibName: The XIB file name if different from the Swift file name.
     * Defaults to the string value of the headerType
     * - Parameter reuseIdentifier: The identifier used to dequeue the view.
     * Defaults to the string value of the headerType
     */
    func registerNibHeader<T: UIView>(ofType headerType: T.Type, nibName: String? = nil, reuseIdentifier: String? = nil) {
        let headerName = String(describing: headerType)
        let nib = UINib(nibName: nibName ?? headerName, bundle: Bundle(for: headerType))
        register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? headerName)
    }
}
