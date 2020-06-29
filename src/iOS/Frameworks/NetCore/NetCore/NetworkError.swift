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
    case decodingFailed(Error)
    
    public var localizedDescription: String {
        switch self {
        case .parametersNil: return "Parameters were nil"
        case .encodingFailed: return "Parameter encoding failed"
        case .missingURL: return "URL is nil"
        case .decodingFailed(let error): return "Decoding data failed, error: \(error)"
        }
    }
}
