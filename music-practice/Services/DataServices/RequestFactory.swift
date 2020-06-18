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
  
  static func call<T>(
    _ Model: T.Type,
    sort: [NSSortDescriptor]? = defaultSort,
    limit: Int? = nil,
    fn: ((inout NSFetchRequest<T>) -> Void)? = nil
  ) -> FetchRequest<T> where T: BaseEntityProtocol {
    
    var request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: Model))
    request.sortDescriptors = sort
    if let limit = limit { request.fetchLimit = limit }
    if let fn = fn { fn(&request) }
    return FetchRequest(fetchRequest: request)
    
  }
}
