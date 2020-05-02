//
//  Storage.swift
//  Storage
//
//  Created by Artem Kufaev on 02.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import CoreData

open class Storage {
    
    let coreData: CoreDataStack
    
    init(with modelName: String) {
        coreData = CoreDataStack(modelName: modelName)
    }
    
//    public func read() {
//
//    }
    
    public func readAll<T: NSManagedObject>() throws -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        let context = coreData.mainContext
        let result = try context.fetch(fetchRequest)
        return result
    }
    
    public func write(_ object: NSManagedObject) throws {
        let context = coreData.mainContext
        try context.save()
    }
    
    public func write(_ objects: [NSManagedObject]) throws {
        let context = coreData.mainContext
        try context.save()
    }
    
}
