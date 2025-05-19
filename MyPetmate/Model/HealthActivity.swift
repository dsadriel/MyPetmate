//
//  HealthActivity.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

struct HealthActivity {
    let name: String
    let category: HealthCategory
    let meseurementAmount: Int
    let repeation: [ActivityRepeation]
    let repeatUntil: Date?
    let reminderIn: TimeInterval?
    var hasReminder: Bool {reminderIn != nil}
    let location: String?
    let notes: String?
}
