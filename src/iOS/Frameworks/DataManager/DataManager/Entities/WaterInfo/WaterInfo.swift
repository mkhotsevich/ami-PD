//
//  WaterInfo.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Storage
import CoreData

public struct WaterInfo: Decodable {
    public let id: Int
    public let amount: Int
    public let drinkedAt: Date
}

extension WaterInfo: ManagedObjectConvertible {
    public typealias ManagedObject = WaterInfoCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject? {
        guard let obj = WaterInfoCD.getOrCreateSingle(with: id, from: context) else { return nil }
        obj.id = Int32(id)
        obj.amount = Int32(amount)
        obj.drinkedAt = drinkedAt
        return obj
    }
}
