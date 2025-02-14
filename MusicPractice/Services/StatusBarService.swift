//
//  StatusBarService.swift
//  MusicPractice
//
//  Created by Sam Garson on 02/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

class MusicPracticeHostingController<Content>: UIHostingController<Content> where Content: View {
  private var internalStyle = UIStatusBarStyle.default
  
  @objc override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
    get {
      internalStyle
    }
    set {
      internalStyle = newValue
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
  
  override init(rootView: Content) {
    super.init(rootView:rootView)
    
    StatusBarEnvironmentKey.defaultValue.getter = { self.preferredStatusBarStyle }
    StatusBarEnvironmentKey.defaultValue.setter = { self.preferredStatusBarStyle = $0 }
  }
  
  @objc required dynamic init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

struct StatusBarEnvironmentKey: EnvironmentKey {
  static let defaultValue: StatusBarService = StatusBarService()
}

extension EnvironmentValues {
  var statusBar: StatusBarService {
    get { return self[StatusBarEnvironmentKey.self] }
  }
}

class StatusBarService {
  fileprivate var getter: () -> UIStatusBarStyle = { .default }
  fileprivate var setter: (UIStatusBarStyle) -> Void = {_ in}
  
  func update(_ color: UIStatusBarStyle) { self.setter(color) }
}
