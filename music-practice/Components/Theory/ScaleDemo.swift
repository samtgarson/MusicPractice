//
//  ScaleDemo.swift
//  music-practice
//
//  Created by Sam Garson on 21/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct ScaleDemo: View {
  var scale: Scale
  
  var body: some View {
    MPRow {
      Text(notes)
        .font(Fonts.notes)
        .frame(maxWidth: .infinity)
    }
  }
  
  private var notes: String {
    NotationHelper(pitches: fullScale).render()
  }
  
  private var fullScale: [Pitch] {
    scale.pitches(octave: 1) + [scale.pitches(octave: 2).first!]
  }
}

struct ScaleDemo_Previews: PreviewProvider {
  static var previews: some View {
    var scales = [Scale]()
    for level in TheoryService.scaleLevels {
      for practiceable in level {
        switch practiceable {
        case .scale(let scale):
          scales.append(scale)
        default:
          break
        }
      }
    }
    
    return PageView {
      ForEach(scales, id: \.self) { scale in
        VStack {
          Text(scale.shortDescription)
          ScaleDemo(scale: scale)
        }.asRowWrapper()
      }
    }
  }
}
