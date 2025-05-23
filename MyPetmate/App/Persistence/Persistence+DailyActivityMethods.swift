//
//  Persistence+DailyActivityMethods.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//
import UIKit

extension Persistence {
    // MARK: - Daily Activity methods
    static func addActivity(_ activity: DailyActivity, to pet: Pet) {
        pet.dailyActivities.append(activity)
        Persistence.updatePet(pet)
        print("foi")
    }
    
    static func deleteActivity(_ activity: DailyActivity, from pet: Pet) {
        if let index = pet.dailyActivities.firstIndex(of: activity) {
            pet.dailyActivities.remove(at: index)
        }
        Persistence.updatePet(pet)
    }
    
    static func excludeActivityOccourence(_ occurrence: DailyActivityOccurrence, from pet: Pet) {
        
        guard !(pet.excludedDailyActivitiesOccurrences[occurrence.date.endOfDay]?.contains(where: { $0 == occurrence }) ?? false) else {
            return
        }
            
        if pet.excludedDailyActivitiesOccurrences[occurrence.date.endOfDay] == nil {
            pet.excludedDailyActivitiesOccurrences[occurrence.date.endOfDay] = [occurrence]
        } else {
            pet.excludedDailyActivitiesOccurrences[occurrence.date.endOfDay]?.append(occurrence)
        }
        
        updatePet(pet)
    }
    
    static func changeActivityOccurrenceCompleteness(_ occurrence: DailyActivityOccurrence, to completeness: Bool, in pet: Pet) {
        if completeness {
            // If it's already completed, ignore
            guard !(pet.completedDailyActivitiesOccurrences[occurrence.date.endOfDay]?.contains(where: { $0 == occurrence }) ?? false) else {
                return
            }
            
            var occurrence = occurrence
            occurrence.isCompleted = true
            
            if pet.completedDailyActivitiesOccurrences[occurrence.date.endOfDay] == nil {
                pet.completedDailyActivitiesOccurrences[occurrence.date.endOfDay] = [occurrence]
            } else {
                pet.completedDailyActivitiesOccurrences[occurrence.date.endOfDay]?.append(occurrence)
            }
                        
            updatePet(pet)
        } else {
            pet.completedDailyActivitiesOccurrences[occurrence.date.endOfDay]?.removeAll(where: {$0 == occurrence})
            updatePet(pet)
        }
    }
    
    
}
