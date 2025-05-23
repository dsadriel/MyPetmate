//
//  Animal.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 16/05/25.
//

enum PetType: String, Codable, CaseIterable, LabelRepresentable {
    case dog = "Dog"
    case cat = "Cat"
    case unknown = "Unknown"

    var systemImageName: String {
        switch self {
        case .dog: return "dog.circle.fill"
        case .cat: return "cat.circle.fill"
        default: return "questionmark.circle.fill"
        }
    }

    var title: String { rawValue }
}
