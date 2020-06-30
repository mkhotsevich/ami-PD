//
//  ProfileViewController.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import DataManager

class ProfileViewController: UIViewController {
    
    private var router: ProfileRouter!

    override func viewDidLoad() {
        super.viewDidLoad()

        router = ProfileRouter(controller: self)
        configureLogoutBtn()
    }
    
    private func configureLogoutBtn() {
        let rightNavBtn = UIBarButtonItem(title: "logout", style: .done, target: self, action: #selector(logout))
        navigationItem.setRightBarButton(rightNavBtn, animated: true)
    }
    
    @objc
    private func logout() {
        showQuestion(title: "Вы уверены?", message: nil, completion: { (isLogout) in
            guard isLogout else { return }
            TokenManager.accessToken = nil
            self.toAuth()
        })
    }

}
