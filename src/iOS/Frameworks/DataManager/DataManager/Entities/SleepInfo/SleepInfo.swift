//
//  SleepInfo.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Storage
import CoreData

public struct SleepInfo: Decodable {
    public let id: String
    public let endAt: Date
    public let riseAt: Date
}

extension SleepInfo: ManagedObjectConvertible {
    public typealias ManagedObject = SleepInfoCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject? {
        guard let obj = SleepInfoCD.getOrCreateSingle(with: id, from: context) else { return nil }
        obj.id = id
        obj.endAt = endAt
        obj.riseAt = riseAt
        return obj
    }
}
