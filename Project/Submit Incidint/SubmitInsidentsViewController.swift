//
//  File.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import  UIKit


class SubmitInsidentsViewController: UIViewController{
    @IBOutlet weak var descriptionField: CustomTextField!
    @IBOutlet weak var typeField: CustomTextField!
    @IBOutlet weak var latField: CustomTextField!
    @IBOutlet weak var longField: CustomTextField!

    let worker: submitWorkable
    init(worker: submitWorkable) {
        self.worker = worker
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setView()
    }


    func setView(){
        descriptionField.placeholder = "Description"
        typeField.placeholder = "Type"
        latField.placeholder = "Latitude"
        longField.placeholder = "Longitude"
    }

    @IBAction func submitTapped() {
        showLoder()
        let id = Int(typeField.text)
        let lat = Double(latField.text)
        let long = Double(longField.text)

        let params = [
            "description": descriptionField.text,
            "typeId": id,
            "latitude": lat,
            "longitude": long,
        ] as [String: AnyObject]? ?? [:]
        worker.submitIncident(data: params) { success in
            self.stopLoader()
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.presentErrorMessege()
            }
        }

    }

}
