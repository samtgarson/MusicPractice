//
//  Clamped.swift
//  MusicPractice
//
//  Created by Sam Garson on 24/02/2025.
//

import Foundation

extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}
