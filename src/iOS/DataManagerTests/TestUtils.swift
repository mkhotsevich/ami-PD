//
//  TestUtils.swift
//  DataManager
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import DataManager

class TestUtils {
    
    static let correctEmail = "test@apihp.ru"
    static let correctPassword = "amihp12345"
    
    static func loginForTest() {
        let auth = AuthManager()
        auth.loginWithEmail(TestUtils.correctEmail,
                            password: TestUtils.correctPassword) { _ in }
    }
    
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    static func randomEmail() -> String {
        return randomString(length: 8) + "@" + randomString(length: 6) + "." + randomString(length: 3)
    }
    
}
