//
//  ArticleManager.swift
//  DataManager
//
//  Created by Artem Kufaev on 31.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import NetworkCore
import Storage

public class ArticleManager: IDataManager<ArticleAPI, Article> {
    
    public func get(completion: @escaping (NetworkResultWithModel<[Article]>) -> Void) {
        let api: ArticleAPI = .getCollection
        self.storage.readAll { completion(.success($0)) }
        provider.load(api) { (result: NetworkResultWithModel<[Article]>) in
            switch result {
            case .success(let articles):
                self.storage.write(articles)
            default: break
            }
            completion(result)
        }
    }
    
}
