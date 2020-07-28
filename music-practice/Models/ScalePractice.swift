//
//  ScalePractice.swift
//  music-practice
//
//  Created by Sam Garson on 14/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import CoreData
import MusicTheorySwift

extension ScalePractice: BaseEntityProtocol, PracticeEntityProtocol {
  var scale: Scale? {
    get {
      guard let scaleId = scaleId else { return nil }

      do {
        return try JSONDecoder().decode(Scale.self, from: Data(scaleId.utf8))
      } catch let err {
        print(err)
        return nil
      }
    }
    set {
      do {
        self.scaleId = try String(data: JSONEncoder().encode(newValue), encoding: .utf8)
      } catch let err {
        print(err)
      }
    }
  }
}
