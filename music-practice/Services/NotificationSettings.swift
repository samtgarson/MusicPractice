//
//  NotificationSettings.swift
//  music-practice
//
//  Created by Sam Garson on 24/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

class NotificationSettings: ObservableObject {
  @Published var practiceTimer: Bool {
    didSet {
      UserDefaults.standard.set(practiceTimer, forKey: Keys.practiceTimer.rawValue)
    }
  }
  
  private enum Keys: String {
    case practiceTimer = "notifications:practiceTimer"
  }
  
  init() {
    self.practiceTimer = UserDefaults.standard.bool(forKey: Keys.practiceTimer.rawValue)
  }
}
