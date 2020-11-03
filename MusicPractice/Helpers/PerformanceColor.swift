//
//  PerformanceColor.swift
//  MusicPractice
//
//  Created by Sam Garson on 10/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI

func performanceColor(for performance: Performance) -> Color {
  switch performance {
  case .Good:
    return Colors.success
  case .Meh:
    return Colors.warning
  case .Bad:
    return Colors.error
  }
}


