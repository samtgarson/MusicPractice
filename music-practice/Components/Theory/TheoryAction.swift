//
//  TheoryAction.swift
//  music-practice
//
//  Created by Sam Garson on 17/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct TheoryAction: View {
  var item: Practiceable
  var label: String?
  
  @State(initialValue: false) var showPracticeScreen: Bool
  
  init(_ item: Practiceable, label: String? = nil) {
    self.item = item
    if let label = label { self.label = label }
  }
  
  var body: some View {
    MPRow(onTap: { self.showPracticeScreen.toggle() }) {
      RowLabel(label ?? defaultLabel)
      TheoryLabel(item)
    }
    .padding(.bottom, Spacing.small)
    .asRowWrapper()
    .sheet(isPresented: $showPracticeScreen) {
      NewPracticeScreen(item: self.item) { self.showPracticeScreen.toggle() }
    }
  }
  
  private var defaultLabel: String {
    switch item {
    case .scale:
      return "Scale"
    default:
      return ""
    }
  }
}

struct TheoryAction_Previews: PreviewProvider {
  static var previews: some View {
    let scale = Scale(type: .minor, key: Key(type: .g, accidental: .sharp))
    return PageView {
      TheoryAction(Practiceable.scale(scale))
      TheoryAction(Practiceable.scale(scale), label: "Next")
    }
  }
}
