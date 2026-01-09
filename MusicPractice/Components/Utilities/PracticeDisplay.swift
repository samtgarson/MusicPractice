//
//  PracticeDisplay.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import SwiftUI


struct PracticeDisplay: Hashable {
  var icon: UIImage
  var iconColor: Color
  var score: Int
  var description: String
  
  static var items: [PracticeDisplay] {
    [
      self.init(icon: Icons.smile, iconColor: Colors.forPerformance(.good), score: 1, description: "It was easy!"),
      self.init( icon: Icons.meh, iconColor: Colors.forPerformance(.meh), score: 0, description: "It was OK, needs more work."),
      self.init(icon: Icons.frown, iconColor: Colors.forPerformance(.bad), score: -1, description: "I found this really difficult.")
    ]
  }
  
  static func with(score: Int) -> PracticeDisplay {
    items.first { $0.score == score }!
  }
  
  var iconImage: Icon {
    Icon(icon, color: iconColor)
  }
}
