//
//  Practiceable.swift
//  MusicPractice
//
//  Created by Sam Garson on 12/02/2025.
//

import MusicTheory
import SwiftUI

enum Practiceable: Hashable, Codable {
  case song(Song)
  case scale(Scale)
  case interval(Interval)

  var type: TheoryType {
    switch self {
    case .interval:
      return TheoryType.Interval
    default:
      return TheoryType.Scale
    }
  }

  var title: String {
    switch self {
    case .scale(let scale):
      return scale.shortDescription
    case .song(let song):
      return song.title
    case .interval(let interval):
      return interval.description
    }
  }

  var icon: UIImage {
    switch self {
    case .song:
      Icons.music
    case .scale:
      Icons.chartNoAxesColumnIncreasing
    case .interval:
      Icons.listMusic
    }
  }
}
