//
//  DataManager.swift
//  DataManager
//
//  Created by Artem Kufaev on 24.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import NetCore
import Storage

open class DataManager {
    
    private let userId: Int
    private let accessToken: String

    private let provider: Provider<NetworkAPI>
    private lazy var bundle = Bundle(for: Self.self)
    private let modelName = "Storage"
    
    public init(userId: Int, accessToken: String) {
        provider = Provider<NetworkAPI>()
        self.userId = userId
        self.accessToken = accessToken
    }
    
    private func getManager<Model: ManagedObjectConvertible>() -> IDataManager<NetworkAPI, Model> {
        let storage = Storage<Model>(modelName: modelName, bundle: bundle)
        return IDataManager(provider: provider, storage: storage)
    }
    
}

// User
extension DataManager {
    
    public func getUserData(completion: @escaping ((Result<User?, NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, User> = getManager()
        manager.loadFromDB { (result) in
            completion(.success(result.first { $0.id == self.userId }))
        }
        manager.loadFromNetworkSingle(api: .getUserData(userId: userId, token: accessToken)) { (result) in
            switch result {
            case .success(let user):
                completion(.success(user) )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

// Parameters
extension DataManager {
    
    // Water
    
    public func getWaterHistory(completion: @escaping ((Result<[WaterInfo], NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, WaterInfo> = getManager()
        manager.loadFromDB { completion(.success($0)) }
        manager.loadFromNetwork(api: .getWaterHistory(userId: userId, token: accessToken)) { (result) in
            switch result {
            case .success(let waterHistory):
                completion(.success(waterHistory) )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func sendWaterInfo(amount: Int, drinkingDate: Date, completion: @escaping ((Result<WaterInfo, NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, WaterInfo> = getManager()
        let api: NetworkAPI = .sendWaterInfo(userId: userId,
                                             token: accessToken,
                                             amount: amount,
                                             drinkingDate: drinkingDate)
        manager.loadFromNetworkSingle(api: api) { (result) in
            switch result {
            case .success(let waterInfo):
                completion(.success(waterInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Sleep
    
    public func getSleepHistory(completion: @escaping ((Result<[SleepInfo], NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, SleepInfo> = getManager()
        manager.loadFromDB { completion(.success($0)) }
        manager.loadFromNetwork(api: .getSleepHistory(userId: userId, token: accessToken)) { (result) in
            switch result {
            case .success(let sleepHistory):
                completion(.success(sleepHistory) )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func sendSleepInfo(endDate: Date, riseDate: Date, completion: @escaping ((Result<SleepInfo, NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, SleepInfo> = getManager()
        manager.loadFromNetworkSingle(api: .sendSleepInfo(userId: userId, token: accessToken, endDate: endDate, riseDate: riseDate)) { (result) in
            switch result {
            case .success(let sleepInfo):
                completion(.success(sleepInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Task
    
    public func getTaskHistory(completion: @escaping ((Result<[TaskInfo], NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, TaskInfo> = getManager()
        manager.loadFromDB { completion(.success($0)) }
        manager.loadFromNetwork(api: .getTaskHistory(userId: userId, token: accessToken)) { (result) in
            switch result {
            case .success(let taskHistory):
                completion(.success(taskHistory) )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func sendTaskInfo(title: String,
                             notificationTime: Date,
                             creationDate: Date,
                             completion: @escaping ((Result<TaskInfo, NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, TaskInfo> = getManager()
        let api: NetworkAPI = .sendTaskInfo(userId: userId,
                                            token: accessToken,
                                            title: title,
                                            notificationTime: notificationTime,
                                            creationDate: creationDate)
        manager.loadFromNetworkSingle(api: api) { (result) in
            switch result {
            case .success(let sleepInfo):
                completion(.success(sleepInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Weight
    
    public func getWeightHistory(completion: @escaping ((Result<[WeightInfo], NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, WeightInfo> = getManager()
        manager.loadFromDB { completion(.success($0)) }
        manager.loadFromNetwork(api: .getWeightHistory(userId: userId, token: accessToken)) { (result) in
            switch result {
            case .success(let weightHistory):
                completion(.success(weightHistory) )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func sendWeightInfo(amount: Double, completion: @escaping ((Result<WeightInfo, NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, WeightInfo> = getManager()
        manager.loadFromNetworkSingle(api: .sendWeightInfo(userId: userId, token: accessToken, amount: amount)) { (result) in
            switch result {
            case .success(let weightInfo):
                completion(.success(weightInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

// Articles
extension DataManager {
    
    public func getArticles(completion: @escaping ((Result<[Article], NetworkError>) -> Void)) {
        let manager: IDataManager<NetworkAPI, Article> = getManager()
        manager.loadFromDB { completion(.success($0)) }
        manager.loadFromNetwork(api: .getArticles) { (result) in
            switch result {
            case .success(let articles):
                completion(.success(articles) )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
