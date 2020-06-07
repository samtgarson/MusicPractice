//
//  SettingsScreen.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

enum SettingsItems: String, CaseIterable {
  case PracticeLog = "Practice log"
}

struct SettingsScreen: View {
  var body: some View {
    PageView {
      PageTitle("Account")
      MusicPracticeList(collection: SettingsItems.allCases) { i in
        self.item(i)
      }
    }
  }
  
  func item(_ item: SettingsItems) -> some View {
    MusicPracticeRow {
      NavigationLink(destination: screen(for: item)) {
        RowLabel(item.rawValue)
      }
      Icon(iconName: .chevronRight)
    }
  }

  func screen(for item: SettingsItems) -> some View {
    switch item {
    case .PracticeLog:
      return PracticeLog()
    }
  }
}

struct SettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationWrapper {
      Seeder {
        SettingsScreen()
      }
    }
  }
}
