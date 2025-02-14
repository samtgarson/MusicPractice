//
//  LevelUpScreen.swift
//  MusicPractice
//
//  Created by Sam Garson on 20/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct LevelUpScreen: View {
  
  internal init(for type: TheoryType, hide: @escaping () -> Void) {
    self.type = type
    self.theoryService = TheoryService(type)
  }
  
  var type: TheoryType
  var theoryService: TheoryService
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    ModalView(
      key: "LevelUpScreen",
      title: "Congratulations!",
      description: "You've reached level \(level) 🎉",
      bgColor: Colors.success
    ) {
      VStack(alignment: .center, spacing: Spacing.medium) {
        Text("You've unlocked:").frame(maxWidth: .infinity, alignment: .leading)
        ForEach(theoryService.currentLevel, id: \.self) { item in
          Text(item.title)
            .fontWeight(.medium)
            .padding(.bottom, -Spacing.small)
        }
        MPButton("Let's do it", icon: Icons.arrowRight, onTap: self.hide)
      }.frame(maxWidth: .infinity)
    }
  }
  
  private func hide () {
    self.presentationMode.wrappedValue.dismiss()
  }
  
  private var level: Int {
    theoryService.level + 1
  }
}

struct LevelUpScreen_Previews: PreviewProvider {
  static var previews: some View {
    LevelUpScreen(for: .Scale, hide: { print("hello!") })
  }
}
