//
//  DailyActivity.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

struct DailyActivity: Codable {
    var id: UUID = UUID()
    var name: String
    var category: DailyCategory
    var measurementAmount: Int
    var repetitions: [ActivityRepeation]
    var reminderIn: TimeInterval?
    var hasReminder: Bool {reminderIn != nil}
    var completedOccurrences: [DailyActivityOccurrence] = []
}

extension DailyActivity: Equatable {
    static func == (lhs: DailyActivity, rhs: DailyActivity) -> Bool {
        lhs.id == rhs.id
    }
}

struct DailyActivityOccurrence: Codable {
    var date: Date
    var activity: DailyActivity
    var isCompleted: Bool = false
}

extension DailyActivityOccurrence: Equatable {
    static func == (lhs: DailyActivityOccurrence, rhs: DailyActivityOccurrence) -> Bool {
        return lhs.date == rhs.date && lhs.activity == rhs.activity
    }
}
