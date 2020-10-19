//
//  RetrieveViewController.swift
//  AskAngela
//
//  Created by The App Experts on 13/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import CoreData

class RetrieveViewController: UIViewController {
    
    var currentNote = Note()
    
    let coreDataController = CoreDataController.shared
    
    let fetchNotes: NSFetchRequest<Note> = Note.fetchRequest()
    
    @IBOutlet weak var retrieveTextView: UITextView!
    
    @IBAction func archiveAction(_ sender: Any) {
        
        let date = Date()
        currentNote.dateArchived = date
        currentNote.archived = true
        coreDataController.saveContext()
        self.reload()
        }
    
    @IBAction func anotherOneAction(_ sender: Any) {
        self.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reload()
    }
    
    func reload() {
        
        let mainContext = coreDataController.mainContext
        
        do {
            
            let notes = try mainContext.fetch(fetchNotes)
            
            var notesArray = [Note]()
            
            for (index, note) in notes.enumerated() {
                if !note.archived {
                notesArray.append(note)
                }
            }
            
            if notesArray.count != 0 {
            
                let randomNumber = Int.random(in: 0..<notesArray.count)

                currentNote = notesArray[randomNumber]
            
                retrieveTextView.text = currentNote.text
                
            }
            
            else {
                retrieveTextView.text = "Nothing to retrieve, your ideas list is empty!"
            }
            
                
                
        } catch let fetch_error {
            retrieveTextView.text = fetch_error.localizedDescription
            print(fetch_error.localizedDescription)
        }
        
    }
    
}

