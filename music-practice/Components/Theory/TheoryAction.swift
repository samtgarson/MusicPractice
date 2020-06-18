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
  var item: TheoryItem
  var label: String?
  
  init(_ item: TheoryItem, label: String? = nil) {
    self.item = item
    if let label = label { self.label = label }
  }
  
  var body: some View {
    MPRow {
      RowLabel(label ?? defaultLabel)
      TheoryLabel(item)
    }
    .padding(.bottom, Spacing.small)
    .asRowWrapper()
  }
  
  private var defaultLabel: String {
    switch item {
    case .scale:
      return "Scale"
    }
  }
}

struct TheoryAction_Previews: PreviewProvider {
  static var previews: some View {
    let scale = Scale(type: .minor, key: Key(type: .g, accidental: .sharp))
    return PageView {
      TheoryAction(TheoryItem.scale(scale))
      TheoryAction(TheoryItem.scale(scale), label: "Next")
    }
  }
}
