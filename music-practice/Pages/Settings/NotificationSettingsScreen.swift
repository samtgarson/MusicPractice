//
//  NotificationSettings.swift
//  music-practice
//
//  Created by Sam Garson on 24/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct NotificationSettingsScreen: View {
  @ObservedObject private var state = NotificationSettings()
  
  var body: some View {
    ChildView(title: "Notifications") {
      VStack(spacing: Spacing.tiny) {
        toggle(for: $state.practiceTimer, title: "Practice timer", description: "Receive a notification when your practice timer is up")
        .fixedSize(horizontal: false, vertical: true)
      }.asRowWrapper()
    }
  }
  
  private func toggle(for model: Binding<Bool>, title: String, description: String?) -> some View {
    MPRow() {
      VStack(alignment: .leading, spacing: Spacing.tiny) {
        Toggle(title, isOn: model)
        Unwrap(description) { description in
          Text(description)
            .font(Fonts.sized(FontSizes.small))
            .padding(.trailing, Spacing.large * 2)
        }
      }
    }
  }
}

struct NotificationSettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      NavigationView {
        NotificationSettingsScreen()
      }
    }
  }
}
