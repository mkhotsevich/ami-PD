//
//  CoreDataStack.swift
//  Storage
//
//  Created by Artem Kufaev on 02.05.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import CoreData

final class CoreDataStack {
    
    private let modelName: String
    private let storeIsReady = DispatchGroup()
    
    // MARK: - Init
    
    init(modelName: String) {
        self.modelName = modelName
        registerStore()
    }
    
    // MARK: - Public
    
    lazy var mainContext: NSManagedObjectContext = {
        storeIsReady.wait()
        return persistentContainer.viewContext
    }()
    
    func makePrivateContext() -> NSManagedObjectContext {
        storeIsReady.wait()
        return persistentContainer.newBackgroundContext()
    }
    
    func saveToStore() {
        saveContext(mainContext)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        storeIsReady.wait()
        
        guard context.hasChanges else {
            debugPrint("Data has not changes")
            return
        }
        do {
            try context.save()
            debugPrint("Data succesfully saved to store")
        } catch {
            debugPrint("Data not saved to store with error \(error)")
        }
    }
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        mainContext.perform {
            block(self.mainContext)
        }
    }
    
    //#5
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    // MARK: - Private
    
    private lazy var persistentContainer: NSPersistentContainer = {
        return NSPersistentContainer(name: self.modelName)
    }()
    
    private func registerStore() {
        storeIsReady.enter()
        
        DispatchQueue.global(qos: .background).async {
            self.persistentContainer.loadPersistentStores { (storeDescription, error) in
                if let url = storeDescription.url {
                    debugPrint("Persistent store created: \(url.absoluteString)")
                }
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
                self.storeIsReady.leave()
            }
        }
    }
    
}
