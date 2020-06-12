//
//  NotificationService.swift
//  music-practice
//
//  Created by Sam Garson on 12/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import UserNotifications


class NotificationService {
  func cancelAll() {
    notificationCenter.removeAllPendingNotificationRequests()
  }
  
  func schedule(in seconds: Double, title: String, body: String) {
    getPermission {
      let content = UNMutableNotificationContent()
      content.title = title
      content.badge = 1
      content.body = body
      content.sound = UNNotificationSound.default
      
      let id = UUID().uuidString
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
      let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
      
      // add our notification request
      self.notificationCenter.add(request)
    }
  }
  
  private var notificationCenter: UNUserNotificationCenter {
    UNUserNotificationCenter.current()
  }
  
  private func getPermission (_ cb: @escaping () -> Void) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
      if success {
        cb()
      } else if let error = error {
        print(error.localizedDescription)
      }
    }
  }
}
