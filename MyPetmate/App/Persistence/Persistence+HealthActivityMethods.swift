//
//  Persistence+HealthActivityMethods.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

extension Persistence {
    // MARK: - Health Activity methods
    static func addActivity(_ activity: HealthActivity, to pet: Pet) {
        pet.healthActivities.append(activity)
        Persistence.updatePet(pet)
    }

    static func deleteActivity(_ activity: HealthActivity, from pet: Pet) {
        if let index = pet.healthActivities.firstIndex(of: activity) {
            pet.healthActivities.remove(at: index)
        }
        Persistence.updatePet(pet)
    }
    
    static func excludeActivityOccourence(_ occurrence: HealthActivityOccurrence, from pet: Pet) {
        
        guard !(pet.excludedHealthActivitiesOccurrences[occurrence.date.endOfDay]?.contains(where: { $0 == occurrence }) ?? false) else {
            return
        }
            
        if pet.excludedHealthActivitiesOccurrences[occurrence.date.endOfDay] == nil {
            pet.excludedHealthActivitiesOccurrences[occurrence.date.endOfDay] = [occurrence]
        } else {
            pet.excludedHealthActivitiesOccurrences[occurrence.date.endOfDay]?.append(occurrence)
        }
        
        updatePet(pet)
    }
    static func changeActivityOccurrenceCompleteness(_ occurrence: HealthActivityOccurrence, to completeness: Bool, in pet: Pet) {
        print("AAA \(completeness)")
        let key =  occurrence.date.endOfDay
        if completeness {
            // If it's already completed, ignore
            if let completionList =  pet.completedHealthActivitiesOccurrences[key], completionList.contains(where: { $0 == occurrence }) {
                return
            }
            
            var occurrence = occurrence
            occurrence.isCompleted = true
            
            if pet.completedHealthActivitiesOccurrences[key] == nil {
                pet.completedHealthActivitiesOccurrences[key] = [occurrence]
            } else {
                pet.completedHealthActivitiesOccurrences[key]?.append(occurrence)
            }
                                    
            updatePet(pet)
        } else {
            pet.completedHealthActivitiesOccurrences[key]?.removeAll(where: {$0 == occurrence})
            updatePet(pet)
        }
    }
}
