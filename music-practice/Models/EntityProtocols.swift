//
//  EntityProtocols.swift
//  music-practice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import CoreData

protocol BaseEntityProtocol: Identifiable, NSManagedObject {
  init(context: NSManagedObjectContext)
  var id: UUID? { get set }
  var createdAt: Date? { get set }
}

protocol PracticeEntityProtocol {
  var createdAt: Date? { get set }
  var score: Int16 { get set }
}
