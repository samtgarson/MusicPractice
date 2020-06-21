//
//  RequestFactory.swift
//  music-practice
//
//  Created by Sam Garson on 18/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

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
}
