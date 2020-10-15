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
    
    @IBOutlet weak var retrieveTextView: UITextView!
    
    
    @IBAction func anotherOneAction(_ sender: Any) {
        self.reload()
        print("One more note")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func reload() {
        
        let coreDataController = CoreDataController.shared
        
        let mainContext = coreDataController.mainContext
        
        let fetchNotes: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            
            let notes = try mainContext.fetch(fetchNotes)
            
            let notesCount = notes.count
            
            var notesArray = [Note]()
            
            for (index, note) in notes.enumerated() {
                notesArray.append(note)
            }
            
            let randomNumber = Int.random(in: 0..<notesCount)
            print(randomNumber)
            
            print(notesArray[randomNumber].text)
            
            retrieveTextView.text = notesArray[randomNumber].text
            
        } catch let fetch_error {
            retrieveTextView.text = fetch_error.localizedDescription
            print(fetch_error.localizedDescription)
        }
        
        
        
    }
    
}

