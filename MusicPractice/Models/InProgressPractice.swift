//
//  InProgressPractice.swift
//  MusicPractice
//
//  Created by Sam Garson on 20/02/2025.
//

import Foundation

struct InProgressPractice: Codable {
  let practiceable: Practiceable
  let startedAt: Date
  let minutesToPractice: Int

  var totalSeconds: Double {
    Double(minutesToPractice * 60)
  }

  func progress(for secondsPast: Double) -> Double {
    return secondsPast / totalSeconds
  }

  var finishedAt: Date {
    startedAt.addingTimeInterval(totalSeconds)
  }

  func secondsPast() -> Double {
    return abs(startedAt.timeIntervalSinceNow).clamped(to: 0...totalSeconds)
  }
}
