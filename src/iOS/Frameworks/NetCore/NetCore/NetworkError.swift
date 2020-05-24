//
//  NetworkError.swift
//  NetCore
//
//  Created by Artem Kufaev on 10.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case parametersNil
    case encodingFailed
    case missingURL
    case decodingFailed(Error, Data)
    
    public var localizedDescription: String {
        switch self {
        case .parametersNil: return "Parameters were nil"
        case .encodingFailed: return "Parameter encoding failed"
        case .missingURL: return "URL is nil"
        case .decodingFailed(let error, let data):
            let msg = "Decoding data failed, error: \(error)"
            if let data = String(data: data, encoding: .utf8) {
                return msg + "\n" + data
            } else {
                return msg
            }
        }
    }
}
