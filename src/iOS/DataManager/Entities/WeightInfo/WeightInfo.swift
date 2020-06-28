//
//  WeightInfo.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Storage
import CoreData

public struct WeightInfo: Decodable {
    public let id: String
    public let amount: Double
    public let weighedAt: Date
}

extension WeightInfo: ManagedObjectConvertible {
    public typealias ManagedObject = WeightInfoCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject? {
        guard let obj = WeightInfoCD.getOrCreateSingle(with: id, from: context) else { return nil }
        obj.id = id
        obj.amount = amount
        obj.weighedAt = weighedAt
        return obj
    }
}
