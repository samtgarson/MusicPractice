//
//  Unwrap.swift
//  music-practice
//
//  Created by Sam Garson on 05/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {
  private let value: Value?
  private let contentProvider: (Value) -> Content
  
  init(_ value: Value?,
       @ViewBuilder content: @escaping (Value) -> Content) {
    self.value = value
    self.contentProvider = content
  }
  
  var body: some View {
    value.map(contentProvider)
  }
}
