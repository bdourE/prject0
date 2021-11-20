//
//  UIViewController+Extensions.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import UIKit

extension UIViewController {

    func presentErrorMessege(){
    let alert = UIAlertController(title: "Alert", message: "Somthing wrong", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }


    func showLoder(){
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func stopLoader(){
        for view in self.view.subviews {
            if let activityIndicator = view as?  UIActivityIndicatorView {
                activityIndicator.stopAnimating()
            }
        }    }

}


