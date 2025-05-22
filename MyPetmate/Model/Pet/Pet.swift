//
//  Pet.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

class Pet: Codable, Equatable {
    var petType: Animal = .unknown
    var id: UUID = UUID()
    var name: String
    var sex: PetSex
    var birthDate: Date
    var breed: String
    var size: PetSize
    var weight: Double
    var allergies: String
    var pictureName: String?
    
    var dailyActivities: [DailyActivity] = []
    var excludedDailyActivitiesOccurrences: [Date : [DailyActivityOccurrence]] = [:]
    var completedDailyActivitiesOccurrences: [Date : [DailyActivityOccurrence]] = [:]
    var healthActivities: [HealthActivity] = []
    
    init(name: String, sex: PetSex, birthDate: Date, breed: String, size: PetSize, weight: Double, allergies: String) {
        self.name = name
        self.sex = sex
        self.birthDate = birthDate
        self.breed = breed
        self.size = size
        self.weight = weight
        self.allergies = allergies
        self.pictureName = nil
    }
    
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        lhs.id == rhs.id
    }
}

extension Pet {
    var weeksOld: Int {
        Calendar.current.dateComponents([.weekOfYear], from: birthDate, to: Date()).weekOfYear ?? 0
    }
}

extension Pet {
    func getActivties(for date: Date) -> [DailyActivityOccurrence] {
        var todayActivities: [DailyActivityOccurrence] = []
        
        let endOfDay = date.endOfDay

        for activity in self.dailyActivities {
            for repetition in activity.repetitions {
                
                // If its only once
                if repetition.interval == .onlyOnce {
                    if Calendar.current.isDate(repetition.start, inSameDayAs: date) {
                        todayActivities.append(
                            DailyActivityOccurrence(date: repetition.start, activity: activity)
                        )
                    }
                } else {
                    // Else, calculate the occoruences
                    var occurrenceIndex = 0
                    
                    while let occurrenceDate = repetition.getOccurrenceByNumber(occurrenceIndex) {
                        
                        // If its past today
                        if occurrenceDate > endOfDay {break}
                        
                        // If its today
                        if Calendar.current.isDate(occurrenceDate, inSameDayAs: date) {
                            var occurrence = DailyActivityOccurrence(date: occurrenceDate, activity: activity)
                            
                            // Check if is completed
                            let isCompleted = {
                                guard let index = self.completedDailyActivitiesOccurrences[endOfDay]?.firstIndex(where: {$0 == occurrence}) else {
                                    return false
                                }
                                return self.completedDailyActivitiesOccurrences[endOfDay]![index].isCompleted
                            }()
                            
                            occurrence.isCompleted = isCompleted
                            
                            if !(self.excludedDailyActivitiesOccurrences[endOfDay]?.contains(occurrence) ?? false) {
                                todayActivities.append(occurrence)
                            }
                        }
                        occurrenceIndex += 1
                    }
                }
            }
        }

       return todayActivities//.sorted {
//            if $0.isCompleted == $1.isCompleted {
//                return $0.date < $1.date
//            } else {
//                return !$0.isCompleted && $1.isCompleted
//            }
//        }

    }
    
    func getTodayActivities() -> [DailyActivityOccurrence] {
        getActivties(for: Date())
    }
    
    func getActivityStatus() -> (done: Int, total: Int){
        let activities = self.getTodayActivities()
        
        let done: Int = activities.count(where: {$0.isCompleted})
        let total: Int = activities.count
        
        return (done, total)
    }
}


// MARK: Pet specializations (Cat, Dog)

class Cat: Pet {
    var bloodType: CatBloodType?
    override init(name: String, sex: PetSex, birthDate: Date, breed: String, size: PetSize, weight: Double, allergies: String){
        super.init(name: name, sex: sex, birthDate: birthDate, breed: breed, size: size, weight: weight, allergies: allergies)
        self.petType = .cat
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Dog: Pet {
    var bloodType: DogBloodType?    
    override init(name: String, sex: PetSex, birthDate: Date, breed: String, size: PetSize, weight: Double, allergies: String){
        super.init(name: name, sex: sex, birthDate: birthDate, breed: breed, size: size, weight: weight, allergies: allergies)
        self.petType = .cat
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
