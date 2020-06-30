//
//  MainViewController.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    private lazy var controllers: [UIViewController] = {
        let sleepManagerVC = SleepManagerViewController()
        sleepManagerVC.tabBarItem = UITabBarItem(title: nil, image: R.image.sleepIcon(), tag: 2)
        sleepManagerVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: nil, image: R.image.profileIcon(), tag: 4)
        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        return [
            waterManagerVC,
            articlesVC,
            sleepManagerVC,
            weightManagerVC,
            profileVC]
    }()
    
    private lazy var waterManagerVC: UIViewController = {
        let waterManagerVC = WaterManagerViewController()
        waterManagerVC.navigationItem.title = "Трекер водички"
        let waterManagerNavC = UINavigationController(rootViewController: waterManagerVC)
        waterManagerNavC.tabBarItem = UITabBarItem(title: nil, image: R.image.waterIcon(), tag: 0)
        waterManagerNavC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return waterManagerNavC
    }()
    
    private lazy var articlesVC: UIViewController = {
        let articlesVC = ArticlesViewController()
        articlesVC.navigationItem.title = "Полезные статьи"
        let articlesNaVC = UINavigationController(rootViewController: articlesVC)
        articlesNaVC.tabBarItem = UITabBarItem(title: nil, image: R.image.articleIcon(), tag: 1)
        articlesNaVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return articlesNaVC
    }()
    
    private lazy var weightManagerVC: UIViewController = {
        let weightManagerVC = WeightHistoryViewController()
        weightManagerVC.navigationItem.title = "Трекер веса"
        let weightManagerNaVC = UINavigationController(rootViewController: weightManagerVC)
        weightManagerNaVC.tabBarItem = UITabBarItem(title: nil, image: R.image.weightIcon(), tag: 3)
        weightManagerNaVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return weightManagerNaVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        tabBar.borderWidth = 0.5
        tabBar.borderColor = .clear
        tabBar.clipsToBounds = true
        let margin: CGFloat = 80
        let divider = UIView(frame: CGRect(x: margin,
                                           y: 0,
                                           width: tabBar.frame.width - margin * 2,
                                           height: 1))
        divider.backgroundColor = UIColor.lightGray
        tabBar.addSubview(divider)
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = R.color.e9765B()
        tabBar.tintColor = R.color.bcb4()
        tabBar.backgroundColor = .clear
        setViewControllers(controllers, animated: true)
    }

}
