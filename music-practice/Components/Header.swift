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
    VStack(spacing: Spacing.small) {
      ZStack {
        bgColor.edgesIgnoringSafeArea(.top)
        HeaderContent(title: title, description: description, performance: performance)
          .padding(Spacing.medium)
      }.padding(EdgeInsets(
        top: 0,
        leading: Spacing.medium * -1,
        bottom: Spacing.small,
        trailing: Spacing.medium * -1
      ))
      content
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .topLeading
        )
        .layoutPriority(1)
      Spacer().layoutPriority(2)
    }
    .onAppear { self.statusBar.update(.lightContent) }
    .onDisappear { self.statusBar.update(.default) }
  }
  
  var bgColor: Color {
    switch performance {
    case .Good:
      return Colors.success
    case .Meh:
      return Colors.warning
    case .Bad:
      return Colors.error
    default:
      return Color.white
    }
  }
}

struct HeaderContent: View {
  var title: String?
  var description: String
  var performance: Performance?
  
  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      Image(self.icon)
      self.title.map { Text($0).opacity(0.5) }
      Text(self.description).fixedSize(horizontal: false, vertical: true)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .foregroundColor(self.fgColor)
  }
  
  var icon: String {
    let color = performance != nil ? "White" : "Blue"
    return "\(color)\(performance ?? Performance.Good)"
  }
  
  var fgColor: Color {
    if performance != nil { return Color.white }
    
    return Colors.primary
  }
}

struct Header_Previews: PreviewProvider {
  static var previews: some View {
    PageView {
      Header(description: "Description", performance: .Good) {
        Text("Body")
        Text("Text")
      }
    }
  }
}
