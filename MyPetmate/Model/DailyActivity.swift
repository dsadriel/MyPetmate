//
//  DailyActivity.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

struct DailyActivity {
    let name: String
    let category: DailyCategory
    let meseurementAmount: Int
    let repeation: [ActivityRepeation]
    let reminderIn: TimeInterval?
    var hasReminder: Bool {reminderIn != nil}
}
