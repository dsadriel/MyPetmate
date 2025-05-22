//
//  HealthCategory.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 16/05/25.
//


enum HealthCategory: String, CaseIterable, LabelRepresentable, Codable {
    case medication = "Medication"
    case vaccines = "Vaccines"
    case appointments = "Appointments"

    var systemImageName: String {
        switch self {
        case .medication: return "pills.fill"
        case .vaccines: return "syringe.fill"
        case .appointments: return "stethoscope"
        }
    }

    var title: String { rawValue }
}
