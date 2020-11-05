//
//  CoreDataController.swift
//  AskAngela
//
//  Created by The App Experts on 13/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataController {
    
//    init() {}
    
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
    
    func insertNote( text: String ) -> Note? {
        
        let context = persistentContainer.viewContext
        
        let newNote = Note(context: context)
        
        newNote.text = text
        newNote.colour = "White"              // Not in use yet, open for extension
        newNote.dateCreated = Date()
        newNote.dateArchived = nil
        newNote.archived = false
        
        return newNote
        
    }
    
    func insertResolution( title: String, text: String, days: [String] ) -> Resolution? {
        
        let context = persistentContainer.viewContext
        
        let newResolution = Resolution(context: context)
       
        newResolution.title = title
        newResolution.text = text
        
        newResolution.dateAdded = Date()
        newResolution.isStreak = false
        newResolution.streakNow = 0
        newResolution.gotNotifiedToday = false
        newResolution.notifyArray = days
        
        return newResolution
        
    }

}


