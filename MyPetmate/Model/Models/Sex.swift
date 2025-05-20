//
//  Sex.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

enum Sex: String, CaseIterable, Codable {
    case male
    case female
    case unknown
    
    var sexString: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .unknown:
            return "Unknown"
        }
    }
}
