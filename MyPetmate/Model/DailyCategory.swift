//
//  DailyCategory.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 16/05/25.
//


enum DailyCategory: String, CaseIterable, LabelRepresentable, Codable {
    case feeding = "Feeding"
    case water = "Water"
    case activity = "Activity"

    var systemImageName: String {
        switch self {
        case .feeding: return "fork.knife"
        case .water: return "drop.fill"
        case .activity: return "figure.walk"
        }
    }

    var measurementUnit: String {
        switch self {
        case .feeding: return "g"
        case .water: return "ml"
        case .activity: return "min"
        }
    }

    var measurementLabel: String {
        switch self {
        case .feeding: return "Portion"
        case .water: return "Portion"
        case .activity: return "Duration"
        }
    }

    var title: String { rawValue }
}
