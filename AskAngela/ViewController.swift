//
//  ViewController.swift
//  AskAngela
//
//  Created by The App Experts on 13/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    var mainMenuArray = ["Put an idea to the to-do list", "Retrieve an idea from to-do list", "See archived ideas", "Add a resolution", "Review your resolutions", "Get a joke to cheer up"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self as? UITableViewDelegate
        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
}

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
        
    else if indexPath.row == 5 {
        
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

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)

            }

            }.resume()
        
    }
        
    else {
    }
    
    
    
}
}
