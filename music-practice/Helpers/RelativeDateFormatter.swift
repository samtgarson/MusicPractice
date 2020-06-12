//
//  RelativeDateFormatter.swift
//  music-practice
//
//  Created by Sam Garson on 12/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation

class RelativeDateFormatter {
  internal init(date: Date) {
    self.date = date
    self.absoluteFormatter.dateStyle = .medium
    self.relativeFormatter.unitsStyle = .full
  }
  
  var date: Date
  
  func format() -> String {
    let isRecent = date.timeIntervalSince(Date() - 30 * 24 * 60 * 60) > 0
    if isRecent {
      return relativeFormatter.localizedString(for: date, relativeTo: Date())
    } else {
      return absoluteFormatter.string(from: date)
    }
  }
  
  private var relativeFormatter = RelativeDateTimeFormatter()
  private var absoluteFormatter = DateFormatter()
}
