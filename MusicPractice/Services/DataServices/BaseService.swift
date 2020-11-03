//
//  BaseService.swift
//  MusicPractice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import UIKit


public class BaseService {
  
  var managedContext: NSManagedObjectContext?
  
  init() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      managedContext = appDelegate.persistentContainer.viewContext
    }
  }
  
  func instantiate<T>(_ Entity: T.Type, _ context: NSManagedObjectContext) -> T where T: BaseEntityProtocol {
    let newInstance = Entity.init(context: context)
    newInstance.id = UUID()
    newInstance.createdAt = Date()
    return newInstance
  }
  
  func fetch<T>(_ request: NSFetchRequest<T>) -> [T] {
    guard let context = managedContext else { return [] }
    
    if let result = try? context.fetch(request) {
      return result
    }
    
    return []
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
