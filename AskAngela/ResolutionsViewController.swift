//
//  ArchiveViewController.swift
//  AskAngela
//
//  Created by The App Experts on 15/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Presents tableview of resolutions
// TODO: Streaks

class ResolutionsViewController: UIViewController {
    
// MARK: - Properties

    @IBOutlet weak var resolutionsTableView: UITableView!
    
    var resolutionsArray = [Resolution]()
    
    // MARK: - viewDidLoad, register tableview
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.load()
        
        self.resolutionsTableView.dataSource = self as UITableViewDataSource
        self.resolutionsTableView.delegate = self
        self.resolutionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
     
    }
    
    // MARK: - Fetch resolutions, create array
    
    func load() {
            
            let coreDataController = CoreDataController.shared
            
            let mainContext = coreDataController.mainContext
            
            let fetchResolutions: NSFetchRequest<Resolution> = Resolution.fetchRequest()
            
            do {
                
                let resolutions = try mainContext.fetch(fetchResolutions)
                
                for (_, resolution) in resolutions.enumerated() {
                    
                    
                        resolutionsArray.append(resolution)
                    
                }
                
            } catch let fetch_error {
                print(fetch_error.localizedDescription)
            }
        
    }
        
}

// MARK: - Sets count and cells for tableview function

extension ResolutionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resolutionsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = String(resolutionsArray[indexPath.row].title!)
        
        return cell
    }
    
}

// MARK: - STREAK functionality
// Streak shows how long you keep current resolution
// If you are not on streak now it shows longest streak ever

extension ResolutionsViewController: UITableViewDelegate {
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let currentResolution = resolutionsArray[indexPath.row]
    
    let streakNow = currentResolution.streakNow
    
    var goAhead = "You "
    
    if (currentResolution.isStreak) {
        
        goAhead += "are on streak for "
        
    }
    
    else {
        goAhead += "were on streak for "
    }
    
    goAhead += String(streakNow) + " days"
    
    let alert = UIAlertController(title: goAhead, message: resolutionsArray[indexPath.row].text, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Wow!", style: .default, handler: nil))

    self.present(alert, animated: true)

}

}
