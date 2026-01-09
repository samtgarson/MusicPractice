//
//  LiveActivityAttributes.swift
//  MusicPractice
//
//  Created by Sam Garson on 23/02/2025.
//
import ActivityKit

struct MusicPracticeWidgetExtensionAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    var secondsPast: Double
  }

  var practice: InProgressPractice
}
