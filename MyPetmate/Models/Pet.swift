//
//  Pet.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 13/05/25.
//
import Foundation

struct Pet: Codable {
    let name: String
    let sex: String
    let breed: String
    let size: String?
    let weight: Int?
    let bloodType: String?
    let allergies: [String]?
    let birthDate: Date?
    let weeksOld: Int?
    let documents: [String]?
}

class PetManager {
    func createPet(name: String, sex: String, breed: String, size: String?, weight: Int?, bloodType: String?, allergies: [String]?, birthDate: Date?, weeksOld: Int?, documents: [String]?) -> Pet {
        return Pet(name: name, sex: sex, breed: breed, size: size, weight: weight, bloodType: bloodType, allergies: allergies, birthDate: birthDate, weeksOld: weeksOld, documents: documents)
    }
    
    func editPet(original: Pet,
                 name: String? = nil,
                 sex: String? = nil,
                 breed: String? = nil,
                 size: String? = nil,
                 weight: Int? = nil,
                 bloodType: String? = nil,
                 allergies: [String]? = nil,
                 birthDate: Date? = nil,
                 weeksOld: Int? = nil,
                 documents: [String]? = nil) -> Pet {
        
        return Pet(
            name: name ?? original.name,
            sex: sex ?? original.sex,
            breed: breed ?? original.breed,
            size: size ?? original.size,
            weight: weight ?? original.weight,
            bloodType: bloodType ?? original.bloodType,
            allergies: allergies ?? original.allergies,
            birthDate: birthDate ?? original.birthDate,
            weeksOld: weeksOld ?? original.weeksOld,
            documents: documents ?? original.documents
        )
    }

}
