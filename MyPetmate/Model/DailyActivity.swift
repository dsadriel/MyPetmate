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
}

extension DailyActivity: Equatable {
    static func == (lhs: DailyActivity, rhs: DailyActivity) -> Bool {
        lhs.id == rhs.id
    }
}

struct DailyActivityOccurrence: Codable, Equatable {
    var date: Date
    var activity: DailyActivity
    var isCompleted: Bool = false
}
