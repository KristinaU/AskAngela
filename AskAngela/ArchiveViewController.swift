//
//  ArchiveViewController.swift
//  AskAngela
//
//  Created by The App Experts on 15/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Archive
// Shows all notes which were archived in a tableview
// On click shows an alert with a note and date when archived

class ArchiveViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var archiveTableView: UITableView!

    var archivedNotesArray = [Note]()
    
    override func viewDidLoad() {
        
        // MARK: - Standard viewDidLoad. Register tableview
        
        super.viewDidLoad()
        self.load()
        
        self.archiveTableView.dataSource = self
        self.archiveTableView.delegate = self
        self.archiveTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
     
    }
    
    // MARK: - Fetch archive. Create array.
    
    func load() {
            
            let coreDataController = CoreDataController.shared
            
            let mainContext = coreDataController.mainContext
            
            let fetchNotes: NSFetchRequest<Note> = Note.fetchRequest()
            
            do {
                
                let notes = try mainContext.fetch(fetchNotes)
                
                for (_, note) in notes.enumerated() {
                    if note.archived {
                        archivedNotesArray.append(note)
                    }
                }
                
            } catch let fetch_error {
                print(fetch_error.localizedDescription)
            }
        
    }
        
}

// MARK: - Set count and cells for tableview function

extension ArchiveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.archivedNotesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = String(archivedNotesArray[indexPath.row].text!)
        return cell
    }
    
}

// MARK: - Create an alert with individual note

extension ArchiveViewController: UITableViewDelegate {
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let currentNote = archivedNotesArray[indexPath.row]
    
    let dateArchived = currentNote.dateArchived
    
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    
    guard dateArchived != nil else { return }
    
    let dateArchivedString = formatter.string(from: dateArchived!)
    
    let alert = UIAlertController(title: "Archived on " + dateArchivedString, message: archivedNotesArray[indexPath.row].text, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

    self.present(alert, animated: true)

}

}
