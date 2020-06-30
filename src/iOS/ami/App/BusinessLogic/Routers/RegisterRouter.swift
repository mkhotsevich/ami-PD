//
//  RegisterRouter.swift
//  ami
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

class RegisterRouter: BaseRouter {
    
    var infoFillVC: RegisterInfoFillViewController?
    
    func toInfoPlaceholder(email: String, password: String) {
        if infoFillVC == nil {
            infoFillVC = RegisterInfoFillViewController()
        }
        infoFillVC?.registerData = (email, password)
        push(infoFillVC!, animated: true)
    }
    
}
