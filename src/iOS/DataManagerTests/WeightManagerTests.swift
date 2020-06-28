//
//  WeightManagerTests.swift
//  DataManager
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import XCTest
@testable import DataManager

class WeightManagerTests: XCTestCase {
    
    lazy var manager: WeightManager = WeightManager()
    
    func testCreating() {
        let exp = self.expectation(description: "Loading from server")
        manager.save(amount: Double.random(in: 1.0...300.0),
                     weighedAt: Date()) { (result) in
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
    
    func testGetting() {
        let exp = self.expectation(description: "Loading from server")
        var count = 0
        manager.get { (result) in
            switch result {
            case .success(let data):
                count += 1
                dump(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            if count == 2 {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testUpdating() {
        let exp = self.expectation(description: "Loading from server")
        manager.get { (result) in
            switch result {
            case .success(let data):
                guard let element = data.first else {
                    XCTFail("Элемент для теста отсутствует")
                    return
                }
                self.manager.update(id: element.id,
                                    amount: Double.random(in: 1.0...300.0),
                                    weighedAt: Date()) { (result) in
                    switch result {
                    case .success(let data):
                        dump(data)
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                    }
                    exp.fulfill()
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testDeleting() {
        let exp = self.expectation(description: "Loading from server")
        manager.get { (result) in
            switch result {
            case .success(let data):
                guard let element = data.first else {
                    XCTFail("Элемент для теста отсутствует")
                    return
                }
                self.manager.delete(id: element.id) { (result) in
                    switch result {
                    case .success:
                        dump("OK")
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                    }
                    exp.fulfill()
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }

}
