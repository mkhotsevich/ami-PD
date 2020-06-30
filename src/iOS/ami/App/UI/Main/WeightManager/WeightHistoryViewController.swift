//
//  WeightHistoryViewController.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import DataManager

private let reuseIdentifier = "reuseIdentifier"

class WeightHistoryViewController: UITableViewController {
    
    var weightManager: WeightManager!
    var weightHistory: [WeightInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightManager = WeightManager()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        loadData()
    }
    
    private func loadData() {
        weightManager.get { (result) in
            switch result {
            case .success(let history):
                self.weightHistory = history
            case .failure(let error):
                self.showAlert(alertText: "Ошибка", alertMessage: error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return weightHistory.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let weightInfo = weightHistory[indexPath.row]
        
        let date = DateHelper.prettyDate(from: weightInfo.weighedAt)
        cell.textLabel?.text = "\(weightInfo.amount) кг \(date)"

        return cell
    }

}
