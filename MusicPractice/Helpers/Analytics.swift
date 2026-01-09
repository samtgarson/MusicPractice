//
//  Analytics.swift
//  MusicPractice
//
//  Created by Sam Garson on 03/11/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import FathomAnalytics

//let analytics = FathomAnalyticsClient(
//  siteID: "DSHBHQKV",
//  environment: "https://music-practice.samgarson.com/production",
//  url: "https://cdn.usefathom.com",
//)

struct FakeAnalytics {
  func track(page: String) {}
  func track(goal: String) {}
}

let analytics = FakeAnalytics()

struct AnalyticsGoals {
  static let completePractice = "BIIHESBR"
}
