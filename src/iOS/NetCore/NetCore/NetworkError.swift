//
//  NetworkError.swift
//  NetCore
//
//  Created by Artem Kufaev on 10.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
    case decodingFailed = "Decoding data failed"
}
