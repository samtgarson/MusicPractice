//
//  formatter.swift
//  MusicPractice
//
//  Created by Sam Garson on 21/02/2025.
//
import SwiftUI

func formatForCountdown(_ seconds: Double) -> String {
  let formatter = DateComponentsFormatter()

  formatter.unitsStyle = .positional
  formatter.allowedUnits = [ .minute, .second ]
  formatter.zeroFormattingBehavior = [ .pad ]

  return formatter.string(from: seconds) ?? ""
}
