//
//  MusicPracticeList.swift
//  MusicPractice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct MPList<T: RandomAccessCollection, R: View>: View where T.Element: Hashable {
  
  internal init(collection: T, displayAction: Bool = true, render: @escaping (T.Element) -> R) {
    self.collection = collection
    self.render = render
  }
  
  var collection: T
  var displayAction: Bool = true
  var render: (T.Element) -> R
  
  var body: some View {
    VStack(spacing: Spacing.tiny) {
      ForEach(collection, id: \.self) { item in
        self.render(item).asRowWrapper()
      }
    }
  }
  
  func withFooter<F: View>(@ViewBuilder _ footer: @escaping () -> F?) -> some View {
    VStack(spacing: Spacing.tiny) {
      body
      footer()
        .opacity(Opacity.veryFaded)
        .asRowWrapper()
    }
  }
}

struct TestRecord: Hashable {
  var name: String
}

struct RowWrapper: ViewModifier {
  func body(content: Content) -> some View {
    content.padding(.horizontal, -Spacing.small)
  }
}

extension View {
  func asRowWrapper() -> some View {
    self.modifier(RowWrapper())
  }
}

struct MPList_Previews: PreviewProvider {
  static var previews: some View {
    let records = [
      TestRecord(name: "Test 1"),
      TestRecord(name: "Test 2"),
      TestRecord(name: "Test 3")
    ]
    
    let action = MPRow() {
      RowLabel("This is an action row")
      Circle().fill(Colors.primary).frame(width: 10, height: 10)
    }
    
    return PageView {
      MPList(collection: records) { record in
        MPRow() {
          RowLabel(record.name)
          Circle().fill(Color.red).frame(width: 10, height: 10)
        }
      }
      .withFooter { action }
      .padding(.bottom, 50)
      
      MPList(collection: records) { record in
        MPRow {
          RowLabel(record.name)
          Circle().fill(Color.red).frame(width: 10, height: 10)
        }
      }
    }.withDefaultStyles()
  }
}
