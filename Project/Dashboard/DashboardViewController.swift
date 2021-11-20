//
//  DashboardViewController.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import Foundation
import UIKit
import Charts

class DashboardViewController: UIViewController {

  @IBOutlet weak var pieChartView: PieChartView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
    super.viewDidLoad()

        let worker = DashboardManager()
        worker.getValues { v in
            self.setChart(dataPoints: v)
        }
  }
    func setChart(dataPoints: [Value]) {
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry1 = PieChartDataEntry(value: Double(i), label: String(dataPoints[i].id), data:  dataPoints[i].count)
        dataEntries.append(dataEntry1)
      }
      let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Incidients")
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      pieChartView.data = pieChartData

      var colors: [UIColor] = []

      for _ in 0..<dataPoints.count {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))

        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      pieChartDataSet.colors = colors
    }
}
