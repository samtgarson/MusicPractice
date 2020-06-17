//
//  WeightedAverage.swift
//  music-practice
//
//  Created by Sam Garson on 10/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import Foundation

typealias weightedValue = (value: Double, weight: Double)

func weightedAverage(_ values: [weightedValue]) -> Double {
  precondition(values.count > 0)
  
  let totalWeight = values.reduce(0.0) { $0 + $1.weight }
  precondition(totalWeight > 0)
  
  return values
    .map { $0.weight * $0.value }
    .reduce(0.0, +) / totalWeight
}
