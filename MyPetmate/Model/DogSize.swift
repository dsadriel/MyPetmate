//
//  DogSize.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 20/05/25.
//

enum DogSize: String, CaseIterable, Codable, SelectableEnum {
    case small
    case medium
    case large
    case giant
    
    var dogSizeString: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .giant:
            return "Giant"
        }
    }
    
    var displayName: String {
        dogSizeString
    }
    
}
