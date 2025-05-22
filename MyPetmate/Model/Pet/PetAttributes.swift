//
//  Pet.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 13/05/25.
//

import Foundation

enum PetSex: String, Codable, CaseIterable, SelectableEnum {
    case male = "Male"
    case female = "Female"
    case unknown = "Unknown"
}

enum PetSize: String, Codable, CaseIterable, SelectableEnum {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

enum CatBloodType: String, Codable, CaseIterable, SelectableEnum {
    case A, B, AB
}

enum DogBloodType: String, Codable, CaseIterable, SelectableEnum {
    case dea1_1 = "DEA 1.1"
    case dea1_2 = "DEA 1.2"
    case dea3   = "DEA 3"
    case dea4   = "DEA 4"
    case dea5   = "DEA 5"
    case dea7   = "DEA 7"
}
