//
//  Persistence+HealthActivityMethods.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

extension Persistence {
    // MARK: - Health Activity methods
    static func addActivity(_ activity: HealthActivity, to pet: Pet) -> Pet {
        pet.healthActivities.append(activity)
        Persistence.updatePet(pet)
        return pet
    }

    static func deleteActivity(_ activity: HealthActivity, from pet: Pet) -> Pet {
        if let index = pet.healthActivities.firstIndex(of: activity) {
            pet.healthActivities.remove(at: index)
        }
        Persistence.updatePet(pet)
        return pet
    }
}
