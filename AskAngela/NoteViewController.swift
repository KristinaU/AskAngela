//
//  NoteViewController.swift
//  AskAngela
//
//  Created by The App Experts on 13/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import CoreData

// MARK: - View controller for adding notes functionality

class NoteViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var outputLabelText: UILabel!
    
    @IBOutlet weak var noteTextField: UITextView!
    
    let coreDataController = CoreDataController.shared
    
    // MARK: - Action to save note and set new Note Core data object
    
    @IBAction func saveNoteAction(_ sender: UIButton) {

        coreDataController.insertNote(text: noteTextField.text)
        
//        let mainContext = coreDataController.mainContext
//        
//        let newNote = Note(context: mainContext)
//        
//        newNote.text = noteTextField.text
//        newNote.colour = "White"              // Not in use yet, open for extension
//        newNote.dateCreated = Date()
//        newNote.dateArchived = nil
//        newNote.archived = false              // Will be true when archived
        
        outputLabelText.text = coreDataController.saveContext() ? "Saved" : "Not saved"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
