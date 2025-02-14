//
//  SettingsScreen.swift
//  MusicPractice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI


struct SettingsScreen: View {
  @State(initialValue: false) var showConfirmReset: Bool
  @State(initialValue: false) var showAboutSheet: Bool
  @EnvironmentObject var mainNav: MainNav

  private enum SettingsItems: String, CaseIterable {
    case PracticeLog = "Practice log"
    case Notifications = "Notification Settings"
  }
  
  var body: some View {
    PageView(key: "SettingsScreen") {
      PageTitle("Settings")
      MPList(collection: SettingsItems.allCases) { i in
        self.item(i)
      }
      
      SectionTitle("About")
        .padding(.top, Spacing.medium)
      aboutRows
      
      SectionTitle("Danger Zone", icon: Icon(Icons.octagonAlert, scale: .small))
        .padding(.top, Spacing.medium)
      resetRow.asRowWrapper()
      
    }
  }
  
  private func item(_ item: SettingsItems) -> some View {
    MPRow {
      NavigationLink(destination: screen(for: item)) {
        RowLabel(item.rawValue)
      }
      Icon(Icons.chevronRight)
    }
  }

  private func screen(for item: SettingsItems) -> some View {
    switch item {
    case .PracticeLog:
      return AnyView(PracticeLog())
    case .Notifications:
      return AnyView(NotificationSettingsScreen())
    }
  }
  
  private var aboutRows: some View {
    VStack(spacing: Spacing.tiny) {
      MPRow(onTap: { self.showAboutSheet = true }) {
        RowLabel("Built by Sam Garson")
        Icon(Icons.heart, scale: .small)
      }.actionSheet(isPresented: $showAboutSheet) { aboutSheet }
      MPRow() {
        RowLabel("Version")
        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
      }.opacity(Opacity.Faded)
    }.asRowWrapper()
  }
  
  private var resetRow: some View {
    MPRow(onTap: { self.showConfirmReset = true }) {
      RowLabel("Factory reset")
      Icon(Icons.trash2, color: Colors.error)
    }
    .actionSheet(isPresented: $showConfirmReset) { resetSheet }
  }
  
  private var aboutSheet: ActionSheet {
    ActionSheet(
      title: Text("Find me on the internet ❤️"),
      buttons: [
        .default(Text("samgarson.com")) { UIApplication.shared.open(URL(string: "https://samgarson.com")!) },
        .default(Text("@samtgarson")) { UIApplication.shared.open(URL(string: "https://twitter.com/samtgarson")!) },
        .cancel(Text("Back"))
      ]
    )
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
//    RequestFactory.destroyEverything()
    mainNav.go(to: .Home)
  }
}

#if DEBUG
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
#endif
