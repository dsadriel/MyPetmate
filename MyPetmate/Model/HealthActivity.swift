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
    let repeation: [ActivityRepeation]
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
