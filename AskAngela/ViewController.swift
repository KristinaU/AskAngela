//
//  ViewController.swift
//  AskAngela
//
//  Created by The App Experts on 13/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mainTextView: UITextView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Array of main menu items
    
    var mainMenuArray = ["Put an idea to the to-do list",
                         "Retrieve an idea from to-do list",
                         "See archived ideas",
                         "Add a resolution",
                         "Review your resolutions",
                         "Get a joke to cheer up"]
    
    // MARK: - Presents a configuration view controller that lets the user configure the post.
    
    func pushConfigurationViewController(_ viewController: UIViewController!) {
    }
    
    // MARK: - viewDidLoad, register main tableview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
}

// MARK: - Functionality for jokes, self-contained

extension ViewController {
    
    func showJoke() {
        
        let urlString = "https://icanhazdadjoke.com/"
        var jokeResponce: [String: Any] = [:]
        
        let url = NSURL(string: urlString)!
        var request = URLRequest(url: url as URL)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
         
          URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else {return}
            if let jsonDictionary = jsonObject as? [String: Any] {
                jokeResponce = jsonDictionary
            }
            
            let joke = jokeResponce["joke"] as! String
            
            DispatchQueue.main.async {

                let alert = UIAlertController(title: "Joke of the day", message: joke, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "More", style: .default) {
                (action) -> Void in
                self.showJoke()
                })
                
                alert.addAction(UIAlertAction(title: "Share", style: .default) {
                    (action) -> Void in
                    let activityViewController = UIActivityViewController(activityItems: [joke], applicationActivities: nil)

                    self.present(activityViewController, animated: true, completion: nil)
                })
                
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                
                
                    self.present(alert, animated: true)

                }
                }.resume()
}
}
// MARK: - Sets count and cells for tableview function

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainMenuArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = mainMenuArray[indexPath.row]
        return cell
    }
    
}

// MARK: - Main menu complete implementation

extension ViewController: UITableViewDelegate {
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    var newWindowViewController: UIViewController;
    
    if indexPath.row == 0 {
        newWindowViewController = storyboard.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        self.navigationController?.pushViewController(newWindowViewController, animated: true)
    }
    
    else if indexPath.row == 1 {
        newWindowViewController = storyboard.instantiateViewController(withIdentifier: "RetrieveViewController") as! RetrieveViewController
        self.navigationController?.pushViewController(newWindowViewController, animated: true)
    }
    
    else if indexPath.row == 2 {
        newWindowViewController = storyboard.instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
        self.navigationController?.pushViewController(newWindowViewController, animated: true)
    }
        
    else if indexPath.row == 3 {
        newWindowViewController = storyboard.instantiateViewController(withIdentifier: "AddResolutionViewController") as! AddResolutionViewController
        self.navigationController?.pushViewController(newWindowViewController, animated: true)
    }
        
    
    else if indexPath.row == 4 {
        newWindowViewController = storyboard.instantiateViewController(withIdentifier: "ResolutionsViewController") as! ResolutionsViewController
        self.navigationController?.pushViewController(newWindowViewController, animated: true)
    }
        
    else if indexPath.row == 5 {
        
        showJoke()
        
    }
        
    else { return }
    
}
    
}
