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
    
    case getUserData(userId: Int, token: String)
    
    case getWaterHistory(userId: Int, token: String)
    case sendWaterInfo(userId: Int, token: String, amount: Int, drinkingDate: Date)
    
    case getSleepHistory(userId: Int, token: String)
    case sendSleepInfo(userId: Int, token: String, endDate: Date, riseDate: Date)
    
    case getTaskHistory(userId: Int, token: String)
    case sendTaskInfo(userId: Int, token: String, title: String, notificationTime: Date, creationDate: Date)
    
    case getWeightHistory(userId: Int, token: String)
    case sendWeightInfo(userId: Int, token: String, amount: Double)
    
    case getArticles
    
    public static var baseUrl = "pacific-peak-31437.herokuapp.com/api/"
}

extension NetworkAPI: INetworkAPI {

    public var schema: NetworkSchema { .https }
    public var host: String { NetworkAPI.baseUrl }
    public var headers: HTTPHeaders? {
        switch self {
        case .getUserData(_, let token):
            return ["token": token]
        default:
            return nil
        }
    }

    public var path: String {
        switch self {
        case .getUserData: return "users"
        default: return ""
        }
    }

    public var httpMethod: HTTPMethod {
        switch self {
        case .getUserData:
            return .get
        default:
            return .get
        }
    }

    public var task: HTTPTask {
        switch self {
        case .getUserData(let userId, _):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["userId": userId])
        default:
            return .request
        }
    }

}
