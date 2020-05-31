//
//  User.swift
//  DataManager
//
//  Created by Artem Kufaev on 23.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Storage
import CoreData

public struct User: Decodable {
    public let id: String
    
    public let email: String
    public let name: String
    public let surname: String
    public let birthdate: Date
    
    public let height: Double
    
    public let appleId: String?
    public let vkId: Int?
}

extension User: ManagedObjectConvertible {
    public typealias ManagedObject = UserCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject? {
        guard let obj = UserCD.getOrCreateSingle(with: id, from: context) else { return nil }
        obj.id = id
        obj.email = email
        obj.name = name
        obj.surname = surname
        obj.birthdate = birthdate
        obj.height = height
        obj.appleId = appleId
        if let vkId = vkId {
            obj.vkId = Int32(vkId)
        }
        return obj
    }
}
