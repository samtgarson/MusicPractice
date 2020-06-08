//
//  WithDragAction.swift
//  music-practice
//
//  Created by Sam Garson on 07/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import NoveFeatherIcons

extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}

struct WithDragAction<Content: View, A: View>: View {
  var content: Content
  var action: () -> Void
  var icon: A
  
  @State(initialValue: 0) private var offset: CGFloat
  @State(initialValue: false) private var showAction: Bool
  
  init(icon: A, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.icon = icon
    self.action = action
  }
  
  var body: some View {
    ZStack(alignment: .trailing) {
      iconView
      contentView
    }
  }
  
  private var iconView: some View {
    icon
      .padding(.trailing, Spacing.small)
      .opacity(self.progress)
      .offset(x: 0, y: self.iconFloat)
      .onTapGesture(perform: self.onTap)
  }
  
  private var contentView: some View {
    self.content
      .background(Colors.background)
      .overlay(tapIntersecter)
      .offset(x: self.offset, y: 0)
      .gesture(self.dragGesture)
  }

  private var tapIntersecter: some View {
    Group {
      if showAction {
        Rectangle()
          .fill(Colors.background)
          .opacity(0.1)
          .onTapGesture {
            if self.showAction {
              self.showAction = false
              self.reset()
            }
        }
      }
    }
  }
  
  private var dragGesture: some Gesture {
    DragGesture()
      .onChanged { gesture in
        let target = self.stationary + gesture.translation.width
        self.offset = min(0, target)
    }
    .onEnded { _ in
      self.showAction = self.offset < -100
      self.reset()
    }
  }
  
  private func reset () {
    withAnimation(.spring()) {
      self.offset = self.stationary
    }
  }
  
  private var stationary: CGFloat {
    self.showAction ? -100 : 0
  }
  
  private var progress: Double {
    Double(self.offset).clamped(to: -100.0...0.0) / -100
  }
  
  private var iconFloat: CGFloat {
    self.offset.clamped(to: -100.0...0.0) / 10 + 10
  }
  
  private func onTap () {
    self.showAction = false
    reset()
    action()
  }
}

struct WithDragAction_Previews: PreviewProvider {
  static var previews: some View {
    func action () { print("actioned!") }
    var icon: some View { Icon(iconName: .package).foregroundColor(Colors.error) }
    
    return PageView {
      WithDragAction(icon: icon, action: action) {
        MPRow(onTap: { print("tapped") }) {
          RowLabel("This is a row")
          Circle().fill(Color.red).frame(width: 10, height: 10)
        }
      }
    }
  }
}
