//
//  WaterManagerViewController.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UIUtils
import DataManager

class WaterManagerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var waterAmountLabel: UILabel!
    @IBOutlet weak var drinkWaterButton: UIButton!
    @IBOutlet weak var waterEnoughLabel: UILabel!
    
    var waterHistory: [WaterInfo] = []
    var weight: WeightInfo? {
        didSet {
            DispatchQueue.main.async {
                if let weight = self.weight {
                    let weight = weight.amount.rounded(toPlaces: 2)
                    self.waterAmountLabel.text = "Количество воды расчитано на \(weight)кг"
                } else {
                    self.waterAmountLabel.text = "Не удалось расчитать вес"
                }
                self.collectionView.reloadData()
            }
        }
    }
    var glassCount: Int {
        let weight = self.weight?.amount ?? 0
        return Int(weight * 30 / 200)
    }
    var waterManager: WaterManager!
    var weightManager: WeightManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        waterManager = WaterManager()
        weightManager = WeightManager()
        loadData()
    }
    
    private func loadData() {
        weightManager.get { (result) in
            switch result {
            case .success(let history):
                self.weight = history.first
            case .failure(let error):
                self.showAlert(alertText: "Ошибка", alertMessage: error.localizedDescription)
            }
        }
        waterManager.get { (result) in
            switch result {
            case .success(let history):
                let calendar = Calendar.current
                self.waterHistory = history.filter { calendar.isDateInToday($0.drinkedAt) }
            case .failure(let error):
                self.showAlert(alertText: "Ошибка", alertMessage: error.localizedDescription)
            }
        }
    }
    
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: "WaterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WaterCellReusable")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func drinkWater(_ sender: Any) {
        waterManager.save(amount: 200, drinkedAt: Date()) { (result) in
            switch result {
            case .success(let info):
                self.addWaterInfoToCollection(info)
            case .failure(let error):
                self.showAlert(alertText: "Ошибка", alertMessage: error.localizedDescription)
            }
        }
    }
    
    private func addWaterInfoToCollection(_ waterInfo: WaterInfo) {
        waterHistory.append(waterInfo)
        DispatchQueue.main.async {
            if self.waterHistory.count == self.glassCount {
                self.drinkWaterButton.isHidden = true
            }
            self.collectionView.reloadData()
        }
    }
    
    private func checkIsWaterEnough() {
        let isWaterEnough = waterHistory.count == glassCount
        drinkWaterButton.isHidden = isWaterEnough
        waterEnoughLabel.isHidden = !isWaterEnough
    }
    
}

extension WaterManagerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return GraphicHelper.calculateSizeOfSquaresInRectangle(rectangleSize: collectionView.bounds.size,
                                                               squareCount: glassCount)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension WaterManagerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checkIsWaterEnough()
        return glassCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterCellReusable",
                                                            for: indexPath) as? WaterCollectionViewCell else { fatalError() }
        if indexPath.row >= waterHistory.count {
            cell.glassIcon.tintColor = R.color.ffb547()
        } else {
            cell.glassIcon.tintColor = R.color.ba2()
        }
        return cell
    }
    
}
