//
//  NetworkAPI.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import NetCore
import Foundation

public enum NetworkAPI {
    case register(email: String, password: String, confirmPassword: String)
    case login(email: String, password: String)
    
    case getUserData(userId: Int)
    
    case getWaterHistory(userId: Int)
    case sendWaterInfo(userId: Int, amount: Int, drinkingDate: Date)
    
    case getSleepHistory(userId: Int)
    case sendSleepInfo(userId: Int, endDate: Date, riseDate: Date)
    
    case getTaskHistory(userId: Int)
    case sendTaskInfo(userId: Int, title: String, notificationTime: Date, creationDate: Date)
    
    case getWeightHistory(userId: Int)
    case sendWeight(userId: Int, amount: Double)
    
    case getArticles
    
    public static var baseUrl = "pacific-peak-31437.herokuapp.com"
}

extension NetworkAPI: INetworkAPI {

    public var schema: NetworkSchema { .https }
    public var host: String { NetworkAPI.baseUrl }
    public var headers: HTTPHeaders? { nil }

    public var path: String {
        return ""
    }

    public var httpMethod: HTTPMethod {
        return .get
    }

    public var task: HTTPTask {
        return .request
    }

}
