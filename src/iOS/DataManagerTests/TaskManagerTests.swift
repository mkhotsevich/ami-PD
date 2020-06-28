//
//  TaskManagerTests.swift
//  DataManagerTests
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import XCTest
@testable import DataManager

class TaskManagerTests: XCTestCase {
    
    lazy var manager: TaskManager = TaskManager()
    
    func testCreating() {
        let exp = self.expectation(description: "Loading from server")
        manager.save(title: TestUtils.randomString(length: 15),
                     notifyAt: Date(timeIntervalSinceNow: 10000),
                     createdAt: Date()) { (result) in
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
        var count = 0
        manager.get { (result) in
            switch result {
            case .success(let data):
                count += 1
                if count != 2 {
                    return
                }
                guard let element = data.first else {
                    XCTFail("Элемент для теста отсутствует")
                    exp.fulfill()
                    return
                }
                self.manager.update(id: element.id,
                                    title: TestUtils.randomString(length: 15),
                                    notifyAt: Date(timeIntervalSinceNow: 31451),
                                    createdAt: Date()) { (result) in
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
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testDeleting() {
        let exp = self.expectation(description: "Loading from server")
        var count = 0
        manager.get { (result) in
            switch result {
            case .success(let data):
                count += 1
                if count != 2 {
                    return
                }
                guard let element = data.first else {
                    XCTFail("Элемент для теста отсутствует")
                    exp.fulfill()
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
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }

}
