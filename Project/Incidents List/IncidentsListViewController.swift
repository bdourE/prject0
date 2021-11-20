//
//  IncidentsListViewController.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import UIKit

protocol IncidentsListInteractable {
    func getIncidentsList(_ reqResponse: @escaping ([Incident]) -> Void)
    func goToFiltersPage()
}

final class IncidentsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UISearchBar!

    var filteredIncidents: [Incident] = []
    var isFiltering = false


    let interactor: IncidentsListInteractable
    var incidents: [Incident] = []
    init(interactor: IncidentsListInteractable) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNibCell(ofType: IncidentTableViewCell.self)
        searchView.delegate = self

        getIncidints()
    }

    func getIncidints(){
        showLoder()
        interactor.getIncidentsList { incidents in
            self.stopLoader()
            self.incidents = incidents
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredIncidents.count : incidents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentTableViewCell") as? IncidentTableViewCell
        else { return UITableViewCell() }
        let current = isFiltering == true ? filteredIncidents[indexPath.row] : incidents[indexPath.row]
        cell.setContent(incedint: current)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.count>0 {
                isFiltering = true
                filteredIncidents = incidents.filter {
                    $0.status == Int(searchText) || $0.createdAt.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                }
            }
            else {
                isFiltering = false
                filteredIncidents = incidents
            }
            self.tableView.reloadData()
    }

    @IBAction func filtersTapped() {
        interactor.goToFiltersPage()
    }
}

