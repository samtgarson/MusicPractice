//
//  BaseService.swift
//  music-practice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import UIKit


public class BaseService {
  var managedContext:NSManagedObjectContext?
  
  init() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      managedContext = appDelegate.persistentContainer.viewContext
    }
  }
  
  func save () {
    guard let context = managedContext else { return }
    
    do {
      try context.save()
    }
    catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
}
