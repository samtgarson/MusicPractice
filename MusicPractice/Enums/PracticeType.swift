//
//  PracticeType.swift
//  MusicPractice
//
//  Created by Sam Garson on 12/02/2025.
//

import Foundation

enum PracticeType: Hashable {
    case song(SongPractice)
    case scale(ScalePractice)

    var createdAt: Date {
        switch self {
        case .scale(let practice):
            return practice.createdAt
        case .song(let practice):
            return practice.createdAt
        }
    }

    var score: Int {
        switch self {
        case .scale(let practice):
            return practice.score
        case .song(let practice):
            return practice.score
        }
    }
}
