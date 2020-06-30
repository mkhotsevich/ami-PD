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

private let cellNibName = "WaterCollectionViewCell"
private let reuseId = "WaterCellReusable"

class WaterManagerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var waterAmountLabel: UILabel!
    @IBOutlet weak var drinkWaterButton: UIButton!
    @IBOutlet weak var waterEnoughLabel: UILabel!
    
    private var router: WaterManagerRouter!
    
    private var waterHistory: [WaterInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.lastFilledGlassIndex = self.waterHistory.count - 1
                self.checkIsWaterEnough()
                self.collectionView.reloadData()
            }
        }
    }
    private var weight: WeightInfo? {
        didSet {
            DispatchQueue.main.async {
                if let weight = self.weight {
                    let weight = weight.amount.rounded(toPlaces: 2)
                    self.waterAmountLabel.text = "Количество воды расчитано на \(weight)кг"
                } else {
                    self.waterAmountLabel.text = "Не удалось расчитать вес"
                }
                self.checkIsWaterEnough()
                self.collectionView.reloadData()
            }
        }
    }
    private var glassCount: Int {
        let weight = self.weight?.amount ?? 0
        return Int(weight * 30 / 200)
    }
    
    private var waterManager: WaterManager!
    private var weightManager: WeightManager!
    private var lastFilledGlassIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        waterManager = WaterManager()
        weightManager = WeightManager()
        router = WaterManagerRouter(controller: self)
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                                            target: self,
                                                            action: #selector(openHistory))
        navigationItem.rightBarButtonItem?.tintColor = R.color.ba2()
    }
    
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: cellNibName, bundle: nil),
                                forCellWithReuseIdentifier: reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc
    private func openHistory() {
        router.toHistory()
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
                self.waterHistory = history
                    .sorted { $0.drinkedAt > $1.drinkedAt }
                    .filter { calendar.isDateInToday($0.drinkedAt) }
            case .failure(let error):
                self.showAlert(alertText: "Ошибка", alertMessage: error.localizedDescription)
            }
        }
    }

    @IBAction func drinkWater(_ sender: Any) {
        lastFilledGlassIndex += 1
        fillGlass(for: lastFilledGlassIndex)
        checkIsWaterEnough()
        saveWater(for: lastFilledGlassIndex)
    }
    
    private func saveWater(for index: Int) {
        waterManager.save(amount: 200, drinkedAt: Date()) { (result) in
            switch result {
            case .success(let info):
                self.waterHistory.append(info)
            case .failure(let error):
                self.fillGlass(for: index)
                self.showAlert(alertText: "Ошибка", alertMessage: error.localizedDescription)
            }
        }
    }
    
    private func fillGlass(for number: Int) {
        let index = IndexPath(row: number, section: 0)
        collectionView.reloadItems(at: [index])
    }
    
    private func checkIsWaterEnough() {
        let isWaterEnough = lastFilledGlassIndex + 1 == glassCount
        drinkWaterButton.isHidden = isWaterEnough
        waterEnoughLabel.isHidden = !isWaterEnough
    }
    
    private func fillGlass(_ cell: WaterCollectionViewCell, for indexPath: IndexPath) {
        let color = indexPath.row > lastFilledGlassIndex ?
            R.color.ffb547() :
            R.color.ba2()
        cell.setColor(color)
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
        return glassCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                            for: indexPath) as? WaterCollectionViewCell else { fatalError() }
        fillGlass(cell, for: indexPath)
        return cell
    }
    
}
