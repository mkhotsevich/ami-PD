//
//  RegisterInfoFillRouter.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

class RegisterInfoFillRouter: BaseRouter {
    
    func toMain() {
        let mainVC = MainViewController()
        var transitionOptions = UIWindow.TransitionOptions.init(direction: .fade, style: .easeInOut)
        transitionOptions.duration = 1
        setRoot(mainVC, transitionOptions: transitionOptions)
    }
    
    func goBack() {
        pop(animated: true)
    }
    
}
