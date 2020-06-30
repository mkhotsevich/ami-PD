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
        let articlesVC = ArticlesViewController()
        articlesVC.tabBarItem = UITabBarItem(title: nil, image: R.image.articleIcon(), tag: 1)
        
        let sleepManagerVC = SleepManagerViewController()
        sleepManagerVC.tabBarItem = UITabBarItem(title: nil, image: R.image.sleepIcon(), tag: 2)
        
        let taskManagerVC = TaskManagerViewController()
        taskManagerVC.tabBarItem = UITabBarItem(title: nil, image: R.image.taskManagerIcon(), tag: 3)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: nil, image: R.image.profileIcon(), tag: 4)
        
        return [
            waterManagerVC,
            articlesVC,
            sleepManagerVC,
            taskManagerVC,
            profileVC]
    }()
    
    private lazy var waterManagerVC: UIViewController = {
        let waterManagerVC = WaterManagerViewController()
        waterManagerVC.navigationItem.title = "Трекер водички"
        let waterManagerNavC = UINavigationController(rootViewController: waterManagerVC)
        waterManagerNavC.tabBarItem = UITabBarItem(title: nil, image: R.image.waterIcon(), tag: 0)
        return waterManagerNavC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = R.color.e9765B()
        tabBar.tintColor = R.color.bcb4()
        tabBar.backgroundColor = .clear
        setViewControllers(controllers, animated: true)
    }

}
