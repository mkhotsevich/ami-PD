//
//  IDataManager.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import NetCore
import Storage

internal class IDataManager<NetworkAPI: INetworkAPI, Model: Decodable & ManagedObjectConvertible> {

    private var provider: Provider<NetworkAPI>
    private var storage: Storage<Model>
    
    public init(provider: Provider<NetworkAPI>, storage: Storage<Model>) {
        self.provider = provider
        self.storage = storage
    }

    internal func loadFromDB(completion: @escaping ([Model]) -> Void) {
        storage.readAll { (data) in
            completion(data)
        }
    }

    internal func loadFromNetworkSingle(api: NetworkAPI, completion: @escaping (Result<Model, NetworkError>) -> Void) {
        provider.load(api) { (result: NetworkResult<Model>) in
            switch result {
            case .success(let data):
                self.saveToDB([data])
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    internal func loadFromNetwork(api: NetworkAPI, completion: @escaping (Result<[Model], NetworkError>) -> Void) {
        provider.load(api) { (result: NetworkResult<[Model]>) in
            switch result {
            case .success(let data):
                self.saveToDB(data)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    internal func saveToDB(_ data: [Model]) {
        storage.write(data)
    }

}
