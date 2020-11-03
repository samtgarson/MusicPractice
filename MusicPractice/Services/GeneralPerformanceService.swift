//
//  HomepagePerformanceService.swift
//  MusicPractice
//
//  Created by Sam Garson on 22/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation

class GeneralPerformanceService: BaseService {
  
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
    fetch(RequestFactory.raw(ScalePractice.self))
  }
  
  private var intervalPractices: [PracticeEntityProtocol] {
    fetch(RequestFactory.raw(IntervalPractice.self))
  }
  
  private var songPractices: [PracticeEntityProtocol] {
    fetch(RequestFactory.raw(SongPractice.self))
  }
  
}
