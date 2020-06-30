//
//  LoginRouter.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

class LoginRouter: BaseRouter {
    
    func toRegister() {
        let registerVC = RegisterViewController()
        var transitionOptions = UIWindow.TransitionOptions.init(direction: .toLeft, style: .easeOut)
        transitionOptions.duration = 0.4
        setRoot(registerVC, transitionOptions: transitionOptions)
    }
    
    func toMain() {
        let mainVC = MainViewController()
        var transitionOptions = UIWindow.TransitionOptions.init(direction: .fade, style: .easeOut)
        transitionOptions.duration = 1
        setRoot(mainVC, transitionOptions: transitionOptions)
    }
    
}
