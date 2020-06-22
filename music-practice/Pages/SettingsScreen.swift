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
  @State(initialValue: false) var showConfirmReset: Bool
  @EnvironmentObject var mainNav: MainNav
  
  var body: some View {
    PageView {
      PageTitle("Account")
      MPList(collection: SettingsItems.allCases) { i in
        self.item(i)
      }.withFooter { self.resetRow }
    }
  }
  
  private func item(_ item: SettingsItems) -> some View {
    MPRow {
      NavigationLink(destination: screen(for: item)) {
        RowLabel(item.rawValue)
      }
      Icon(iconName: .chevronRight)
    }
  }

  private func screen(for item: SettingsItems) -> some View {
    switch item {
    case .PracticeLog:
      return PracticeLog()
    }
  }
  
  private var resetRow: some View {
    MPRow(onTap: { self.showConfirmReset = true }) {
      RowLabel("Factory reset")
      Icon(iconName: .trash2, color: Colors.error)
    }
    .actionSheet(isPresented: $showConfirmReset) { resetSheet }
  }
  
  private var resetSheet: ActionSheet {
    ActionSheet(
      title: Text("Are you sure you want to factory reset?"),
      message: Text("You'll lose all of your songs and practices."),
      buttons: [
        .destructive(Text("Yes, reset everything")) { self.reset() },
        .cancel(Text("Never mind"))
      ]
    )
  }
  
  private func reset () {
    RequestFactory.destroyEverything()
    mainNav.go(to: .Home)
  }
}

struct SettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationWrapper {
      Seeder {
        SettingsScreen()
          .environmentObject(MainNav())
      }
    }
  }
}
