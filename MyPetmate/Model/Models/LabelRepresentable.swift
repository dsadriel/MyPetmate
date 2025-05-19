//
//  CategoryAndAnimal.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 16/05/25.
//

protocol LabelRepresentable {
    var title: String { get }
    var systemImageName: String { get }
}

    enum healthCategory: String, CaseIterable, LabelRepresentable {
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

    enum dailyCategory: String, CaseIterable, LabelRepresentable {
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
        
        var measures: String {
            switch self {
            case .feeding: return "g"
            case .water: return "ml"
            case .activity: return "min"
            }
        }
        
        var measuresLabel: String {
            switch self {
            case .feeding: return "Portion"
            case .water: return "Portion"
            case .activity: return "Duration"
            }
        }
        
        var title: String { rawValue }
    }

    enum animal: String, CaseIterable, LabelRepresentable {
        case dog = "Dog"
        case cat = "Cat"
        
        var systemImageName: String {
            switch self {
            case .dog: return "dog.circle.fill"
            case .cat: return "cat.circle.fill"
            }
        }
        
        var title: String { rawValue }
    }
