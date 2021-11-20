//
//  FiltersTableController.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import UIKit

protocol FiltersRoutable {
    func goToList(choosenFilters: [Int])
}
final class FiltersTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!


    let router: FiltersRoutable
    let netowrkManager = NetworkManager.sharedInstance
    var filters: [Type] = []
    var choosenFilters: [Int] = []

    init(router: FiltersRoutable ) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNibCell(ofType: FilterTableViewCell.self)
        getFilters()
    }

    func getFilters(){
        netowrkManager.loadData(.getFilters, auth_token: nil) { reponse, status in
            if status == 200 , let reponse = reponse{
                do {
                    let data = try? reponse.rawData()
                    let decoder = JSONDecoder()
                    self.filters = try decoder.decode([Type].self, from: data as! Data)
                    self.tableView.reloadData()
                } catch {
                    print("error:\(error)")
                }
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return filters.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters[section].subTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell") as? FilterTableViewCell
        else { return UITableViewCell() }
        cell.setContent(name: filters[indexPath.section].subTypes[indexPath.row].englishName)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].englishName
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenFilters.append(filters[indexPath.section].subTypes[indexPath.row].categoryId)
    }


    @IBAction func applyTapped() {
        router.goToList(choosenFilters: choosenFilters)
    }
}
