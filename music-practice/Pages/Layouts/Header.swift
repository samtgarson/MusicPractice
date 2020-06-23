//
//  Header.swift
//  music-practice
//
//  Created by Sam Garson on 01/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//
import SwiftUI

struct Header<Content: View>: View {
  internal init(title: String? = nil, description: String, performance: Performance? = nil, @ViewBuilder content: () -> Content) {
    self.title = title
    self.description = description
    self.performance = performance
    self.content = content()
  }
  
  var title: String?
  var description: String
  var performance: Performance?
  var content: Content
  
  @Environment(\.statusBar) var statusBar
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        bgColor.edgesIgnoringSafeArea(.top)
        HeaderContent(title: title, description: description, performance: performance)
          .fixedSize(horizontal: false, vertical: true)
          .padding(Spacing.medium)
      }
      
      ScrollView(.vertical) {
        Spacer().frame(height: Spacing.medium)
        content
          .padding(.horizontal, Spacing.medium)
          .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
      }
      .layoutPriority(1)
    }
    .onAppear { self.statusBar.update(.lightContent) }
    .onDisappear { self.statusBar.update(.default) }
    .withDefaultStyles()
  }
  
  var bgColor: Color {
    if let performance = performance {
      return Colors.forPerformance(performance)
    }
    
    return Color.white
  }
}

struct Header_Previews: PreviewProvider {
  static var previews: some View {
    Header(title: "Long title title title title title title title title title title title title ", description: "Description", performance: .Good) {
      Text("Body")
      Text("Text")
      Rectangle().stroke(Colors.error).frame(height: 1200)
    }
  }
}
