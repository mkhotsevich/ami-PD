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
        let waterManagerVC = WaterManagerViewController()
        waterManagerVC.tabBarItem = UITabBarItem(title: nil, image: R.image.waterIcon(), tag: 0)
        
        let articlesVC = ArticlesViewController()
        articlesVC.tabBarItem = UITabBarItem(title: nil, image: R.image.articleIcon(), tag: 1)
        
        let sleepManagerVC = SleepManagerViewController()
        sleepManagerVC.tabBarItem = UITabBarItem(title: nil, image: R.image.sleepIcon(), tag: 2)
        
        let taskManagerVC = TaskManagerViewController()
        taskManagerVC.tabBarItem = UITabBarItem(title: nil, image: R.image.taskManagerIcon(), tag: 3)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: nil, image: R.image.profileIcon(), tag: 4)
        
        return [waterManagerVC,
                articlesVC,
                sleepManagerVC,
                taskManagerVC,
                UINavigationController(rootViewController: profileVC)]
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
        setViewControllers(controllers, animated: true)
    }

}
