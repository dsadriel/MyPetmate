//
//  Animal.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 16/05/25.
//

enum Animal: String, CaseIterable, LabelRepresentable {
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
