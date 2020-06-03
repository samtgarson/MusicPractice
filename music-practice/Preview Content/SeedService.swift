//
//  SeedService.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

#if DEBUG
import CoreData
import UIKit
import SwiftUI

class SeedService {
  var context: NSManagedObjectContext
  
  init() {
    context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  }
  
  func render<T : View>(_ fn: () -> T) -> some View {
    fn().environment(\.managedObjectContext, context)
  }
  
  func seedSongs() -> SeedService {
    _ = clearAll(Song.self)
    for i in 1...5 {
      SongService().create(title: "Song \(i)")
    }
    
    return self
  }
  
  func clearAll<T: NSManagedObject>(_ Entity: T.Type) -> SeedService {
    let entityName = String(describing: Entity.self)
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    try! context.execute(deleteRequest)
    
    return self
  }
}
#endif
