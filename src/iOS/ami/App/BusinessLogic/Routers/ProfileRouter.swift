//
//  ProfileRouter.swift
//  ami
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

class ProfileRouter: BaseRouter {
    
    func toRegister() {
        let registerVC = RegisterViewController()
        var transitionOptions = UIWindow.TransitionOptions.init(direction: .fade, style: .easeOut)
        transitionOptions.duration = 1
        setRoot(registerVC, transitionOptions: transitionOptions)
    }
    
}
