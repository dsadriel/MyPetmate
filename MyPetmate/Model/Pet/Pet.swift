//
//  Pet.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

class Pet: Codable, Equatable {
    var petType: Animal {
            return .unknown
    }
    
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
    var excludedDailyActivitiesOccurrences: [DailyActivityOccurrence] = []
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
        
        let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date)!

        for activity in self.dailyActivities {
            for repetition in activity.repetitions {
                if repetition.interval == .onlyOnce {
                    if Calendar.current.isDate(repetition.start, inSameDayAs: date) {
                        todayActivities.append(
                            DailyActivityOccurrence(date: repetition.start, activity: activity)
                        )
                    }
                    
                } else {
                    var occurrenceIndex = 0
                    while let occurrenceDate = repetition.getOccurrenceByNumber(occurrenceIndex) {
                        if occurrenceDate > endOfDay {
                            break
                        }
                        
                        if Calendar.current.isDate(occurrenceDate, inSameDayAs: date) {
                            let occurrence = DailyActivityOccurrence(date: occurrenceDate, activity: activity)
                            if !self.excludedDailyActivitiesOccurrences.contains(occurrence) {
                                todayActivities.append(occurrence)
                            }
                        }
                        occurrenceIndex += 1
                    }
                }
            }
        }

        return todayActivities
    }
    
    func getTodayActivities() -> [DailyActivityOccurrence] {
        getActivties(for: Date())
    }
    
    func getActivityStatus() -> (done: Int, total: Int){
        let activities = self.getTodayActivities()
        
        let done: Int = activities.count(where: {$0.isCompleted})
        let total: Int = activities.count - done
        
        return (done, total)
    }
}


// MARK: Pet specializations (Cat, Dog)

class Cat: Pet {
    var bloodType: CatBloodType?
    override var petType: Animal {
        return .cat
    }
}

class Dog: Pet {
    var bloodType: DogBloodType?
    override var petType: Animal {
        return .dog
    }
}
