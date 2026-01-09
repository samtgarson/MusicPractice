//
//  LiveActivityService.swift
//  MusicPractice
//
//  Created by Sam Garson on 23/02/2025.
//
import ActivityKit

typealias PracticeLiveActivity = Activity<MusicPracticeWidgetExtensionAttributes>

class PracticeLiveActivityService {
  let practice: InProgressPractice
  var activity: PracticeLiveActivity?

  init(practice: InProgressPractice) {
    self.practice = practice
  }

  func start() {
    guard ActivityAuthorizationInfo().areActivitiesEnabled else {
      print("Live Activities not enabled")
      return
    }

    do {
      let attributes = MusicPracticeWidgetExtensionAttributes(practice: practice)
      let initialState = MusicPracticeWidgetExtensionAttributes.ContentState(
        secondsPast: Double(practice.minutesToPractice * 60)
      )

      self.activity = try Activity.request(
        attributes: attributes,
        content: .init(state: initialState, staleDate: nil),
        pushType: .none
      )
    } catch {
      print("Error starting Live Activity: \(String(describing: error))")
    }
  }

  func update() async {
    guard let activity = activity else { return }

    let state = MusicPracticeWidgetExtensionAttributes.ContentState(
      secondsPast: practice.secondsPast()
    )
  
    await activity.update(
      ActivityContent<MusicPracticeWidgetExtensionAttributes.ContentState>(
        state: state,
        staleDate: nil,
        relevanceScore: 50
      )
//      alertConfiguration: alertConfig
    )
  }

  func finish() async {
    guard let activity = activity else { return }
    let finalState = MusicPracticeWidgetExtensionAttributes.ContentState(secondsPast: 0)

    await activity.end(ActivityContent(state: finalState, staleDate: nil))
  }
}
