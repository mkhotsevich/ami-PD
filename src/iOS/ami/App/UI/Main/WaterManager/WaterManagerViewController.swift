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
    
    var waterHistory: [WaterInfo] = []
    var weight: WeightInfo? {
        didSet {
            DispatchQueue.main.async {
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
                fatalError(error.localizedDescription)
            }
        }
        waterManager.get { (result) in
            switch result {
            case .success(let history):
                let calendar = Calendar.current
                self.waterHistory = history.filter { calendar.isDateInToday($0.drinkedAt) }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: "WaterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WaterCellReusable")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension WaterManagerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return GraphicHelper.calculateSizeOfSquaresInRectangle(rectangleSize: collectionView.frame.size, squareCount: glassCount)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension WaterManagerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return glassCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterCellReusable",
                                                            for: indexPath) as? WaterCollectionViewCell else { fatalError() }
        if indexPath.row >= waterHistory.count,
            let myImage = R.image.glassIcon() {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            cell.glassIcon.image = tintableImage
        }
        return cell
    }
    
}
