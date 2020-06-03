//
//  FormService.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//
import Foundation

typealias FormModel = Dictionary<String, String>

class FormService: ObservableObject {
  @Published var submitted = false
  @Published var model: FormModel = Dictionary()
  
  func get(_ key: String) -> String? {
    model[key]
  }
  
  func set(_ key: String, value: String) {
    model[key] = value
  }
}
