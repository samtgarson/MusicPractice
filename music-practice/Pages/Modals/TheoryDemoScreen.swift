//
//  TheoryDemoScreen.swift
//  music-practice
//
//  Created by Sam Garson on 22/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct TheoryDemoScreen: View {
  var item: Practiceable
  var scale: Scale?
  var done: () -> Void
  
  init(_ item: Practiceable, done: @escaping () -> Void) {
    self.item = item
    self.done = done
    
    switch item {
    case .scale(let scale):
      self.scale = scale
    default:
      break
    }
  }
  
  var body: some View {
    Header(title: "Ready to practice \(item.title)", description: "Here's a quick reminder. Ready to go?") {
      VStack(spacing: Spacing.medium) {
        Unwrap(scale) { scale in
          MPList(collection: [scale]) { scale in
            ScaleDemo(scale: scale)
          }
          
        }
        MPButton("Practice time", icon: .arrowRight, onTap: self.done)
      }
    }
  }
}

struct TheoryDemoScreen_Previews: PreviewProvider {
  static var previews: some View {
    let scale = Scale(type: .major, key: Key(type: .e))
    let done = { print("done!") }
    return TheoryDemoScreen(Practiceable.scale(scale), done: done)
  }
}
