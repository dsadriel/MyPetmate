//
//  Persistence+DailyActivityMethods.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

extension Persistence {
    // MARK: - Daily Activity methods
    static func addActivity(_ activity: DailyActivity, to pet: Pet) -> Pet {
        pet.dailyActivities.append(activity)
        Persistence.updatePet(pet)
        return pet
    }

    static func deleteActivity(_ activity: DailyActivity, from pet: Pet) {
        if let index = pet.dailyActivities.firstIndex(of: activity) {
            pet.dailyActivities.remove(at: index)
        }
        Persistence.updatePet(pet)
    }

    static func excludeActivityOccourence(_ occurrence: DailyActivityOccurrence, from pet: Pet) {
        guard !pet.excludedDailyActivitiesOccurrences.contains(where: { $0 == occurrence }) else {
                return
        }
        pet.excludedDailyActivitiesOccurrences.append(occurrence)
        updatePet(pet)
    }
}
