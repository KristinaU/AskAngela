//
//  CoreDataController.swift
//  AskAngela
//
//  Created by The App Experts on 13/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation
import CoreData

class CoreDataController {
    
    private init() {}
    
    static let shared = CoreDataController()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AskAngela")
        container.loadPersistentStores(completionHandler : { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError ("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
        
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return false
    }
    
}


