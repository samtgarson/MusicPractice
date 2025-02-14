//
//  HomepagePerformanceService.swift
//  MusicPractice
//
//  Created by Sam Garson on 22/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation

@MainActor
class GeneralPerformanceService {
  var repo: ModelRepository

  init(repo: ModelRepository = .init()) {
    self.repo = repo
  }

  var performance: Performance? {
    if allPractices.count < 4 { return nil }
    
    let metric = 1 - PracticePerformanceService(allPractices).priority
    return PracticePerformanceService.metricToPerformance(metric)
  }
  
  var intervalPerformance: Performance? {
    if intervalPractices.count < 4 { return nil }
    
    let metric = 1 - PracticePerformanceService(intervalPractices).priority
    return PracticePerformanceService.metricToPerformance(metric)
  }
  
  var scalePerformance: Performance? {
    if scalePractices.count < 4 { return nil }
    
    let metric = 1 - PracticePerformanceService(scalePractices).priority
    return PracticePerformanceService.metricToPerformance(metric)
  }
  
  private var allPractices: [PracticeEntityProtocol] {
    scalePractices + songPractices
  }

  private var scalePractices: [PracticeEntityProtocol] {
    return repo.query(ScalePractice.self)
  }
  
  private var intervalPractices: [PracticeEntityProtocol] {
    return repo.query(IntervalPractice.self)
  }
  
  private var songPractices: [PracticeEntityProtocol] {
    return repo.query(SongPractice.self)
  }
  
}
