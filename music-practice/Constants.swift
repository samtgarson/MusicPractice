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
  static let tiny: CGFloat = 6.0
  static let small: CGFloat = 14.0
  static let medium: CGFloat = 32.0
}

let CornerRadius: CGFloat = 5.0

enum Performance {
  case Good
  case Bad
  case Meh
}

struct Opacity {
  static let Faded: Double = 0.75
  static let VeryFaded: Double = 0.65
}

struct FontSizes {
  static let body: CGFloat = 22.0
  static let small: CGFloat = body * 0.55
  static let large: CGFloat = body * 1.5
  static let huge: CGFloat = body * 2.5
}

struct Fonts {
  static let body = Font.custom("Inter-Light", size: FontSizes.body)
  static let small = Font.custom("Inter-Light", size: FontSizes.small).weight(.medium)
  static let large = Font.custom("Inter-Light", size: FontSizes.large)
  static let notes = Font.custom("MusiQwik", size: FontSizes.huge)
  
  static func sized(_ size: CGFloat) -> Font {
    Font.custom("Inter-Light", size: size)
  }
}
