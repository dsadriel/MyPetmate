//
//  HealthActivity.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

struct HealthActivity: Codable {
    var id: UUID = UUID()
    let name: String
    let category: HealthCategory
    let measurementAmount: Int
    let repeations: [ActivityRepeation]
    let repeatUntil: Date?
    let reminderIn: TimeInterval?
    var hasReminder: Bool {reminderIn != nil}
    let location: String?
    let notes: String?
}

extension HealthActivity: Equatable {
    static func == (lhs: HealthActivity, rhs: HealthActivity) -> Bool {
        lhs.id == rhs.id
    }
}

struct HealthActivityOccurrence: Codable {
    var date: Date
    var activity: HealthActivity
    var isCompleted: Bool = false
}

extension HealthActivityOccurrence: Equatable {
    static func == (lhs: HealthActivityOccurrence, rhs: HealthActivityOccurrence) -> Bool {
        return lhs.date == rhs.date && lhs.activity == rhs.activity
    }
}
