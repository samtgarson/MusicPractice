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

extension NSManagedObjectContext {
  
  /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
  ///
  /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
  /// - Throws: An error if anything went wrong executing the batch deletion.
  public func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
    batchDeleteRequest.resultType = .resultTypeObjectIDs
    let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
    let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
  }
}

struct Seeder<Content : View>: View {
  var context: NSManagedObjectContext
  var content: Content
  
  init(_ fn: () -> Content) {
    content = fn()
    context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  }
  
  var body: some View {
    VStack {
      content
      HStack {
        Button(action: { self.seedAllEntities() }) { Text("Seed data") }
        Button(action: { self.clearAllEntities() }) { Text("Clear data") }
      }
    }
    .environment(\.managedObjectContext, context)
  }
  
  func seedAllEntities() {
    for i in 1...5 {
      SongService().create(title: "Song \(i)")
    }
  }
  
  func clearAllEntities() {
    _ = clearAll(Song.self)
  }
  
  func clearAll<T: NSManagedObject>(_ Entity: T.Type) {
    let entityName = String(describing: Entity.self)
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    try! context.executeAndMergeChanges(using: deleteRequest)
  }
}
#endif
