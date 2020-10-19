//
//  DataBaseHelper.swift
//  AskAngela
//
//  Created by The App Experts on 19/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation
import UIKit

class DataBaseHelper {
static let shareInstance = DataBaseHelper()
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
func saveImage(data: Data) {
let imageInstance = Resolution(context: context)
imageInstance.img = data
do {
try context.save()
print("Image is saved")
} catch {
print(error.localizedDescription)
      }
   }
}
