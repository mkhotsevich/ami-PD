//
//  TaskInfo.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Storage
import CoreData

public struct TaskInfo: Decodable {
    public let id: String
    public let title: String
    public let notifyAt: Date
    public let createdAt: Date
}

extension TaskInfo: ManagedObjectConvertible {
    public typealias ManagedObject = TaskInfoCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject? {
        guard let obj = TaskInfoCD.getOrCreateSingle(with: id, from: context) else { return nil }
        obj.id = id
        obj.title = title
        obj.notifyAt = notifyAt
        obj.createdAt = createdAt
        return obj
    }
}
