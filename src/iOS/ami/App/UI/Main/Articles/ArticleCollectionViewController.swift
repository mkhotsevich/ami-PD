//
//  ArticlesViewController.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import DataManager

private let reuseIdentifier = "Cell"
private let cellNibName = "ArticleCollectionViewCell"
private let padding: CGFloat = 20

class ArticlesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var articleManager: ArticleManager!
    private var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private var router: ArticleRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        collectionView = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        router = ArticleRouter(controller: self)
        
        self.view = view
        
        articleManager = ArticleManager()
        collectionView.register(UINib(nibName: cellNibName,
                                      bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifier)
        
        loadData()
    }
    
    private func loadData() {
        articleManager.get { (result) in
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure(let error):
                self.showAlert(alertText: "Ошибка!", alertMessage: error.localizedDescription)
            }
        }
    }
    
}

extension ArticlesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - padding * 3) / 2
        let height = collectionView.frame.width / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
}

// MARK: UICollectionViewDataSource

extension ArticlesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath)
            as? ArticleCollectionViewCell else { fatalError() }
        
        let article = articles[indexPath.row]
        cell.setTitle(article.title)
        switch indexPath.row % 3 {
        case 0: cell.setColor(R.color.a845())
        case 1: cell.setColor(R.color.ffb547())
        case 2: cell.setColor(R.color.bcb4())
        default: break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        router.toContentViewer(article: article)
    }

}
