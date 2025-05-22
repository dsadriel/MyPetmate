//
//  Persistence+PetMethods.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

extension Persistence {
    // MARK: - Pet methods
    static func getPetList() -> [Pet] {
        return Persistence.getApplicaitonData().registeredPets
    }

    static func getPetById(_ id: UUID) -> Pet? {
        return Persistence.getApplicaitonData().registeredPets.first { $0.id == id }
    }

    static func getPetByName(_ name: String) -> Pet? {
        return Persistence.getApplicaitonData().registeredPets.first { $0.name == name }
    }

    static func updatePet(_ pet: Pet) {
        var appData = Persistence.getApplicaitonData()
        if let index = appData.registeredPets.firstIndex(of: pet) {
            appData.registeredPets[index] = pet
        }
        Persistence.saveApplicaitonData(appData)
    }

    static func deletePet(_ pet: Pet) {
        var appData = Persistence.getApplicaitonData()
        if let index = appData.registeredPets.firstIndex(of: pet) {
            appData.registeredPets.remove(at: index)
        }
        Persistence.saveApplicaitonData(appData)
    }

    static func addPet(_ pet: Pet) {        
        if let _ = appData.registeredPets.firstIndex(of: pet) {
            return
        }
        
        appData.registeredPets.append(pet)
        Persistence.saveApplicaitonData(appData)
    }
}
 
