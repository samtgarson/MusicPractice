//
//  Sticky.swift
//  MusicPractice
//
//  Created by Sam Garson on 05/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct Sticky<Content: View>: View {
  var content: (GeometryProxy) -> Content
  var sticky: StickyService = StickyService()
  @State(initialValue: 0) var initY: CGFloat
  
  init(@ViewBuilder content: @escaping (GeometryProxy) -> Content) {
    self.content = content
  }
  
  var body: some View {
    GeometryReader { geometry in
      self.content(geometry)
        .offset(x: 0, y: self.sticky.offset(geometry))
        .onAppear {
          self.initY = geometry.frame(in: .global).minY
      }
    }
  }
}

class StickyService {
  var initY: CGFloat?
  
  func offset(_ geometry: GeometryProxy) -> CGFloat {
    let offset = geometry.frame(in: .global).minY
    
    if initY == nil, offset > 0 {
      self.initY = offset
    }
    
    let initY = self.initY ?? 0
    
    if offset >= initY {
      return initY-offset
    }
    
    return 0
  }
}

