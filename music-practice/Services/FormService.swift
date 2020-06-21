//
//  FormService.swift
//  music-practice
//
//  Created by Sam Garson on 03/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//
import SwiftUI

typealias FormModel = Dictionary<String, String>

class FormService: ObservableObject {
  @Published var submitted = false
  @Published var model: FormModel = FormModel()
  @Published var valid: Bool = true
  
  func get(_ key: String) -> String? {
    model[key]
  }
  
  func set(_ key: String, value: String) {
    self.submitted = false
    model[key] = value
  }
}

struct FormValidationKey: PreferenceKey {
  static var defaultValue: Bool = false
  
  static func reduce(value: inout Bool, nextValue: () -> Bool) {
    value = value && nextValue()
  }
}
