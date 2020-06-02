//
//  Constants.swift
//  music-practice
//
//  Created by Sam Garson on 31/05/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

struct Colors {
  static let background = Color("Background")
  static let primary = Color("Primary")
  static let success = Color("Success")
  static let warning = Color("Warning")
  static let error = Color("Error")
}

struct Spacing {
  static let small: CGFloat = 18.0
  static let medium: CGFloat = 25.0
}

let CornerRadius: CGFloat = 5.0

enum Performance {
  case Good
  case Bad
  case Meh
}
