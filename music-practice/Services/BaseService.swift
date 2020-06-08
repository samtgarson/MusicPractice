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
  
  static let defaultSort = [NSSortDescriptor(key: "createdAt", ascending: true)]
  
  var managedContext:NSManagedObjectContext?
  
  init() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      managedContext = appDelegate.persistentContainer.viewContext
    }
  }
  
  func instantiate<T>(_ Entity: T.Type, _ context: NSManagedObjectContext) -> T where T: EntityProtocol {
    var newInstance = Entity.init(context: context)
    newInstance.id = UUID()
    newInstance.createdAt = Date()
    return newInstance
  }
  
  func save () {
    guard let context = managedContext else { return }
    
    do {
      try context.save()
      context.refreshAllObjects()
    }
    catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
}
