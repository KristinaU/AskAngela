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
        
        initStubs()
        
        sut = CoreDataController.shared
    }

    override func tearDown() {
        
        flushData()
        
        super.tearDown()
    }
    
    func test_create_note() {
        
        //Given the text & colour
        let text = "Note 1"
        let colour = "Cyan"
        
        //When add note
        let note = sut.insertNote(text: text, colour: colour)
        
        //Assert: return note item
        XCTAssertNotNil( note )

    }
    
    func test_fetch_all_notes() {
        
        //When fetch
        let results = sut.fetchAll()
        
        //Assert return 5 note items
        XCTAssertEqual(results.count, 5)
    }
    
    
    func test_save() {
        
        //Give a note item
        let text = "Test Note"
        let colour = "White"
        
        _ = expectationForSaveNotification()
        
        _ = sut.insertNote(text: text, colour: colour)
        
        //Assert save is called via notification (wait)
        expectation(forNotification: NSNotification.Name(rawValue: Notification.Name.NSManagedObjectContextDidSave.rawValue), object: nil, handler: nil)
        
        sut.saveContext()
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        
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
    
    //MARK: Convinient function for notification
    var saveNotificationCompleteHandler: ((Notification)->())?
    
    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        return expect
    }
    
    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    
    func contextSaved( notification: Notification ) {
        print("\(notification)")
        saveNotificationCompleteHandler?(notification)
    }

}

//MARK: Creat some fakes
extension CoreDataTests {
    
    func initStubs() {
        
        func insertNote( text: String, colour: String) -> Note? {
            
            let objNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: mockPersistentContainer.viewContext)
            
            objNote.setValue(text, forKey: "text")
            objNote.setValue(colour, forKey: "colour")
            objNote.setValue(Date(), forKey: "dateCreated")
            objNote.setValue(nil, forKey: "dateArchived")
            objNote.setValue(false, forKey: "archived")

            return objNote as? Note
        }
        
        _ = insertNote(text: "This is a test Note 1", colour: "White")
        _ = insertNote(text: "This is a test Note 2", colour: "Green")
        _ = insertNote(text: "This is a test Note 3", colour: "Red")
        _ = insertNote(text: "This is a test Note 4", colour: "Blue")
        _ = insertNote(text: "This is a test Note 5", colour: "Yellow")
        
        
        do {
            try mockPersistentContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
        
    }
    
    func flushData() {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let objs = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistentContainer.viewContext.delete(obj)
        }
        
        try! mockPersistentContainer.viewContext.save()
        
    }
 
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Note")
        let results = try! mockPersistentContainer.viewContext.fetch(request)
        return results.count
    }
    
}
