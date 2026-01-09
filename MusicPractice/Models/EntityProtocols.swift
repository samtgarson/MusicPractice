//
//  EntityProtocols.swift
//  MusicPractice
//
//  Created by Sam Garson on 06/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation
import SwiftData

protocol PracticeEntityProtocol {
  var createdAt: Date { get set }
  var score: Int { get set }
  var minutesPracticed: Int { get set }
}
