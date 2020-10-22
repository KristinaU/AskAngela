//
//  AddResolutionViewController.swift
//  AskAngela
//
//  Created by The App Experts on 19/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl
import SwiftUI

class AddResolutionViewController: UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var selectedDays: [String] = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"]
    
    
    @IBOutlet weak var resolutionTitle: UITextField!
    
    @IBOutlet weak var resolutionText: UITextView!
    
    @IBOutlet weak var outputLabelText: UILabel!
    
    @IBAction func saveResolutionAction(_ sender: UIButton) {
           
        let coreDataController = CoreDataController.shared
        
        let mainContext = coreDataController.mainContext
           
        let newResolution = Resolution(context: mainContext)
           
        newResolution.title = resolutionTitle.text
        newResolution.text = resolutionText.text
        newResolution.dateAdded = Date()
        newResolution.isStreak = false
        newResolution.streakNow = 0
        newResolution.gotNotifiedToday = false
        newResolution.notifyArray = selectedDays
        
        
        outputLabelText.text = coreDataController.saveContext() ? "Saved" : "Not saved"
           
       }
    
    @IBOutlet weak var weCanDoIt: UIImageView!
    
    @IBAction func setOwnImage(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        weCanDoIt.image = userPickedImage
        picker.dismiss(animated: true)
        
    }
    
    @IBOutlet weak var selectNotifications: MultiSelectSegmentedControl!
    
    @objc func selectionChanged(multiSelectSegmentedControl: MultiSelectSegmentedControl) {
        
        self.selectedDays = multiSelectSegmentedControl.selectedSegmentTitles
        
        print(multiSelectSegmentedControl.selectedSegmentTitles)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        selectNotifications.items = [
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
        "Sun"]
        selectNotifications.selectedBackgroundColor = .blue
        selectNotifications.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
    
        let _: IndexSet = selectNotifications.selectedSegmentIndexes

       
    }

    
    
    
}
