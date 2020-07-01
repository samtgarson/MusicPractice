//
//  CollapsibleSection.swift
//  music-practice
//
//  Created by Sam Garson on 10/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct CollapsibleSection<Content: View>: View {
  var content: Content
  var title: String?
  @State(initialValue: false) var expanded: Bool
  
  init(title: String? = nil, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.title = title
  }
  
  var body: some View {
    VStack {
      HStack {
        Unwrap(self.title) { title in SectionTitle(title) }
        Spacer()
        Icon(iconName: .chevronUp)
          .rotationEffect(expanded ? Angle(degrees: 180) : Angle.zero)
      }
      .onTapGesture { self.toggle() }
      .padding(.horizontal, Spacing.small)
      
      self.content
        .padding(.horizontal, Spacing.small)
        .frame(maxHeight: self.expanded ? .infinity : 0, alignment: .top).clipped()
        .opacity(expanded ? 1 : 0)
        .allowsHitTesting(expanded)
    }.asRowWrapper()
  }
  
  private func toggle() {
    print("toggling")
    withAnimation {
      self.expanded.toggle()
    }
  }
}

struct CollapsibleSection_Previews: PreviewProvider {
  static var previews: some View {
    Seeder {
      SongsScreen()
    }
  }
}
