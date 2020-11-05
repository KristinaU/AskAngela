//
//  CoreDataTests.swift
//  AskAngelaTests
//
//  Created by The App Experts on 05/11/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import XCTest
import CoreData
@testable import AskAngela

class CoreDataTests: XCTestCase {
    
    var sut: CoreDataController!

    override func setUp() {
        
        super.setUp()
        
//        initStubs()
        
        sut = CoreDataController()
    }

    override func tearDown() {
        
        flushData()
        
        super.tearDown()
    }
    
    func test_create_note() {
        
        //Given the text
        let text = "Testable Note 2"
        
        //When add note
        let note = sut.insertNote(text: text)
        
        //Assert: return note item
        XCTAssertNotNil( note )

    }
    
    func test_create_resolution() {
        
        //Given the title and text
        let title = "Title 1"
        let text = "Text 2"
        let days = ["Mon", "Sat", "Sun"]
        
        //When add resolution
        let resolution = sut.insertResolution(title: title, text: text, days: days)
        
        //Assert: return resolution item
        XCTAssertNotNil( resolution )

    }


    
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PersistentContainer", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    

}

//MARK: Creat some fakes
extension CoreDataTests {
    
    
    func flushData() {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let objs = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistentContainer.viewContext.delete(obj)
        }
        
        try! mockPersistentContainer.viewContext.save()
        
    }
 
}
