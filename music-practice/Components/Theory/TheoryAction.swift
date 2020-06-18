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
  var item: TheoryType
  
  init(_ item: TheoryType) {
    self.item = item
  }
  
  var body: some View {
    MPRow {
      RowLabel(label)
      TheoryLabel(item)
    }
  }
  
  private var label: String {
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
      TheoryAction(TheoryType.scale(scale)).asRowWrapper()
    }
  }
}
