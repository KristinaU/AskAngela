//
//  AddResolutionViewController.swift
//  AskAngela
//
//  Created by The App Experts on 19/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation
import UIKit

class AddResolutionViewController: UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var weCanDoIt: UIImageView!
    
    @IBAction func setOwnImage(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        weCanDoIt.image = userPickedImage
        picker.dismiss(animated: true)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
