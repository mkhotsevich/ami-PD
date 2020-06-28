//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created by Artem Kufaev on 28.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import XCTest
@testable import DataManager

class AuthManagerTests: XCTestCase {
    
    lazy var auth: AuthManager = AuthManager()
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    func testRegister() {
        let exp = self.expectation(description: "Loading from server")
//        auth.register(email: "kufaevartem@icloud.com",
//                      password: "5965732561",
//                      name: "Артем",
//                      surname: "Куфаев",
//                      birthdate: 916126984,
//                      weight: 81, height: 181.5,
//                      appleId: "qfwqwfk12l31",
//                      vkId: 305991725) { (result) in
//            switch result {
//            case .success(let data):
//                data.user.birthdate
//                dump(data)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            exp.fulfill()
//        }
        auth.register(email: randomString(length: 8) + "@" + randomString(length: 6) + "." + randomString(length: 3),
                         password: randomString(length: 15),
                         name: randomString(length: 5),
                         surname: randomString(length: 8),
                         birthdate: Int.random(in: 10...10),
                         weight: Double.random(in: 10...300),
                         height: Double.random(in: 30...240),
                         appleId: randomString(length: 10),
                         vkId: Int.random(in: 1...10000)) { (result) in
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLogin() {
        let exp = self.expectation(description: "Loading from server")
        auth.loginWithEmail("kufaevartem@icloud.com", password: "5965732561") { (result) in
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginNotCorrectPassword() {
        let exp = self.expectation(description: "Loading from server")
        auth.loginWithEmail("kufaevartem@icloud.com", password: "123124125") { (result) in
            switch result {
            case .success(let data):
            dump(data)
                XCTFail("Сервер пропустил некорректный пароль")
            case .failure(let error):
                print(error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginBadEmail() {
        let exp = self.expectation(description: "Loading from server")
        auth.loginWithEmail("fjqwpfjqpwf", password: "123124125") { (result) in
            switch result {
            case .success(let data):
            dump(data)
                XCTFail("Сервер пропустил некорректную почту")
            case .failure(let error):
                print(error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginNotCorrectEmail() {
        let exp = self.expectation(description: "Loading from server")
        auth.loginWithEmail("kafq@mail.com", password: "123124125") { (result) in
            switch result {
            case .success(let data):
            dump(data)
                XCTFail("Сервер пропустил некорректную почту")
            case .failure(let error):
                print(error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRestore() {
        let exp = self.expectation(description: "Loading from server")
        auth.restore(with: "kufaevartem@icloud.com") { (result) in
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
