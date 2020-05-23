//
//  Article.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import CoreData
import Storage

public struct Article: Decodable {
    public let id: Int
    public let title: String
    public let content: String
    public let createdAt: Date
}

extension Article: ManagedObjectConvertible {
    public typealias ManagedObject = ArticleCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject? {
        guard let obj = ArticleCD.getOrCreateSingle(with: id, from: context) else { return nil }
        obj.id = Int32(id)
        obj.title = title
        obj.content = content
        obj.createdAt = createdAt
        return obj
    }
}
