//
//  AuthManager.swift
//  DataManager
//
//  Created by Artem Kufaev on 31.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import NetworkCore
import Storage
import CryptoSwift

public class AuthManager: IDataManager<AuthAPI, User> {
    
    public func register(email: String,
                         password: String,
                         name: String,
                         surname: String,
                         birthdate: Int,
                         weight: Double,
                         height: Double,
                         appleId: String?,
                         vkId: Int?,
                         completion: @escaping (NetworkResultWithModel<AuthData>) -> Void) {
        let api: AuthAPI = .register(email: email,
                                     password: password.md5(),
                                     name: name,
                                     surname: surname,
                                     birthdate: birthdate,
                                     weight: weight,
                                     height: height,
                                     appleId: appleId,
                                     vkId: vkId)
        provider.load(api) { (result: NetworkResultWithModel<AuthData>) in
            switch result {
            case .success(let response):
                self.storage.write(response.user)
                TokenManager.accessToken = response.accessToken
            default: break
            }
            completion(result)
        }
    }
    
    public func loginWithEmail(_ email: String, password: String,
                               completion: @escaping (NetworkResultWithModel<AuthData>) -> Void) {
        let api: AuthAPI = .login(email: email, password: password, appleId: nil, vkId: nil)
        provider.load(api) { (result: NetworkResultWithModel<AuthData>) in
            switch result {
            case .success(let response):
                self.storage.write(response.user)
                TokenManager.accessToken = response.accessToken
            default: break
            }
            completion(result)
        }
    }
    
}
