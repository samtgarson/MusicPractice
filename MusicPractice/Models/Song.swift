//
//  Song.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import CoreData

extension Song: BaseEntityProtocol {
  public var practiceArray: [SongPractice] {
    practices?.allObjects.sorted(by: { a, b in
      guard let a = a as? SongPractice,
            let b = b as? SongPractice,
            let aDate = a.createdAt,
            let bDate = b.createdAt else { return false }
      
      return aDate <= bDate
    }) as? [SongPractice] ?? []
  }
}
