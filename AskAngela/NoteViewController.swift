//
//  NoteViewController.swift
//  AskAngela
//
//  Created by The App Experts on 13/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {

    
    @IBOutlet weak var outputLabelText: UILabel!
    
    @IBOutlet weak var noteTextField: UITextView!
    
    let coreDataController = CoreDataController.shared
    
    @IBAction func saveNoteAction(_ sender: UIButton) {
        
        let mainContext = coreDataController.mainContext
        
        let newNote = Note(context: mainContext)
        
        newNote.text = noteTextField.text
        newNote.colour = "White"
        newNote.dateCreated = Date()
        newNote.dateArchived = nil
        newNote.archived = false
        
        outputLabelText.text = coreDataController.saveContext() ? "Saved" : "Not saved"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
