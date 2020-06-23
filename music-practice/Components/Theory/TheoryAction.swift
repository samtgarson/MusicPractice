//
//  TheoryAction.swift
//  music-practice
//
//  Created by Sam Garson on 17/06/2020.
//  Copyright © 2020 Sam Garson. All rights reserved.
//

import SwiftUI
import MusicTheorySwift

struct TheoryAction: View {
  var type: TheoryType
  var label: String?
  var theoryService: TheoryService
  
  @State(initialValue: .None) var modalContent: ModalContent
  
  enum ModalContent {
    case NewPractice
    case Demo
    case Level
    case None
  }

  init(_ type: TheoryType, label: String? = nil) {
    self.type = type
    if let label = label { self.label = label }
    
    self.theoryService = TheoryService(type)

  }
  
  var body: some View {
    MPRow(onTap: { self.modalContent = .Demo }) {
      RowLabel(label ?? defaultLabel)
      TheoryLabel(item)
    }
    .asRowWrapper()
    .sheet(isPresented: showModal) {
      Group {
        if self.modalContent == .Level { self.levelModal }
        if self.modalContent == .Demo { self.demoModal }
        if self.modalContent == .NewPractice { self.newPracticeModal }
      }
    }
  }
  
  var showModal: Binding<Bool> {
    Binding<Bool>(
      get: { self.modalContent != .None },
      set: { self.modalContent = $0 ? .NewPractice : .None }
    )
  }
  
  private var item: Practiceable {
    self.theoryService.next
  }
  
  private mutating func refreshNextItem () {
    self.theoryService = TheoryService(self.type)
  }
  
  private var demoModal: some View {
    TheoryDemoScreen(item, done: { self.modalContent = .NewPractice })
  }
  
  private var levelModal: some View {
    LevelUpScreen(for: item.type, hide: self.dismissModal)
  }
  
  private func dismissModal() {
    self.modalContent = .None
  }
  
  private var newPracticeModal: some View {
    NewPracticeScreen(item: self.item) {
      self.dismissModal()
      
      if self.theoryService.levelIfPossible() {
        self.modalContent = .Level
      }
    }
  }
  
  private var defaultLabel: String {
    switch item {
    case .scale:
      return "Scale"
    default:
      return "Next"
    }
  }
}

struct TheoryAction_Previews: PreviewProvider {
  static var previews: some View {
    return PageView {
      TheoryAction(.Scale)
      TheoryAction(.Scale, label: "Next")
    }
  }
}
