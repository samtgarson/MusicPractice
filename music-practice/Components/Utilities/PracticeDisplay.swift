//
//  PracticeDisplay.swift
//  music-practice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import NoveFeatherIcons
import SwiftUI


struct PracticeDisplay: Hashable {
  var icon: Feather.IconName
  var iconColor: Color
  var score: Int16
  var description: String
  
  static var models: [PracticeDisplay] {
    [
      self.init(icon: .smile, iconColor: Colors.success, score: 1, description: "It was easy!"),
      self.init(icon: .meh, iconColor: Colors.warning, score: 0, description: "It was OK, needs more work."),
      self.init(icon: .frown, iconColor: Colors.error, score: -1, description: "I found this really difficult.")
    ]
  }
  
  static func with(score: Int16) -> PracticeDisplay? {
    models.first { $0.score == score }
  }
  
  var iconImage: Icon {
    Icon(iconName: icon, color: iconColor)
  }
}
