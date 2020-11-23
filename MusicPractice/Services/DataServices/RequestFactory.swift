//
//  RequestFactory.swift
//  MusicPractice
//
//  Created by Sam Garson on 18/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import CoreData
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

class RequestFactory {
  static let defaultSort = [NSSortDescriptor(key: "createdAt", ascending: true)]
  
  /// Creates a fetch request for the given entity
  /// - Parameters:
  ///   - Model: The entity to fetch
  ///   - sort: A sort descriptor, defaults to createdAt
  ///   - limit: Fetch limit, defaults to 0 (i.e. fetch everything)
  ///   - fn: A closure which receives the created NSFetchRequest and can modify it (e.g. to add predicates, properties to group by, etc)
  /// - Returns: A FetchRequest which can be unwrapped to access the fetched resources
  
  static func raw<T>(
    _ Model: T.Type,
    sort: [NSSortDescriptor]? = defaultSort,
    limit: Int? = nil,
    _ fn: ((inout NSFetchRequest<T>) -> Void)? = nil
  ) -> NSFetchRequest<T> where T: BaseEntityProtocol {
    
    var request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: Model))
    request.sortDescriptors = sort
    if let limit = limit { request.fetchLimit = limit }
    if let fn = fn { fn(&request) }
    return request
  }
  
  static func call<T>(
    _ Model: T.Type,
    sort: [NSSortDescriptor]? = defaultSort,
    limit: Int? = nil,
    fn: ((inout NSFetchRequest<T>) -> Void)? = nil
  ) -> FetchRequest<T> where T: BaseEntityProtocol {
    return FetchRequest(fetchRequest: raw(Model, sort: sort, limit: limit, fn))
  }
  
  static func destroyEverything() {
    RequestFactory().destroyAll(SongPractice.self)
    RequestFactory().destroyAll(ScalePractice.self)
    RequestFactory().destroyAll(Song.self)
  }
  
  var managedContext: NSManagedObjectContext?
  
  init() {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      managedContext = appDelegate.persistentContainer.viewContext
    }
  }
  
  func destroyAll<T: NSManagedObject>(_ Entity: T.Type) {
    guard let context = managedContext else { return }
    
    let entityName = String(describing: Entity.self)
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try context.executeAndMergeChanges(using: deleteRequest)
    } catch {
      print("Could not save: \(error).")
    }
  }
}
