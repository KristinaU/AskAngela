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
    
    
    var mainMenuArray = ["Put an idea to the to-do list", "Get an idea from to-do list", "Add a resolution", "Review your resolutions", "See horoscope for today"]
    
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
    print ("row tapped")

}
}
