//
//  Pet.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

class Pet: Codable {
    var petType: PetType = .unknown
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
    var excludedDailyActivitiesOccurrences: [Date: [DailyActivityOccurrence]] = [:]
    var completedDailyActivitiesOccurrences: [Date: [DailyActivityOccurrence]] = [:]
    var healthActivities: [HealthActivity] = []
    var excludedHealthActivitiesOccurrences: [Date: [HealthActivityOccurrence]] = [:]
    var completedHealthActivitiesOccurrences: [Date: [HealthActivityOccurrence]] = [:]

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
}

extension Pet {
    var weeksOld: Int {
        Calendar.current.dateComponents([.weekOfYear], from: birthDate, to: Date()).weekOfYear ?? 0
    }

    var ageString: String {
        let yearsOld = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        let monthsOld = Calendar.current.dateComponents([.month], from: birthDate, to: Date()).month ?? 0

        if yearsOld > 0 {
            return "\(yearsOld) \(yearsOld == 1 ? "year" : "years") old"
        }

        if monthsOld > 0 {
            return "\(monthsOld) \(monthsOld == 1 ? "month" : "month") old"
        }

        return "< 1 month old"
    }
}

extension Pet: Equatable {
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - getDailyActivties
extension Pet {
    func getDailyActivties(for date: Date) -> [DailyActivityOccurrence] {
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
                        if occurrenceDate > endOfDay { break }

                        // If its today
                        if Calendar.current.isDate(occurrenceDate, inSameDayAs: date) {
                            var occurrence = DailyActivityOccurrence(date: occurrenceDate, activity: activity)

                            // Check if is completed
                            let isCompleted = {
                                guard
                                    let index = self.completedDailyActivitiesOccurrences[endOfDay]?.firstIndex(where: {
                                        $0 == occurrence
                                    })
                                else {
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

        return todayActivities
    }

    func getTodayActivities() -> [DailyActivityOccurrence] {
        getDailyActivties(for: Date())
    }

    func getDailyActivitiesStatus() -> (done: Int, total: Int) {
        let activities = self.getTodayActivities()

        let done: Int = activities.count(where: { $0.isCompleted })
        let total: Int = activities.count

        return (done, total)
    }
}
// MARK: - getNextHealthActivities
extension Pet {
    func getNextHealthActivities() -> [HealthActivityOccurrence] {
        var nextActivities: [HealthActivityOccurrence] = []

        for activity in self.healthActivities {
            for repetition in activity.repeations {

                // If it's only once
                if repetition.interval == .onlyOnce {
                    let occurrence = HealthActivityOccurrence(date: repetition.start, activity: activity)
                    if let alreadyCompleted = self.completedHealthActivitiesOccurrences[repetition.start.endOfDay]?
                        .contains(where: { $0 == occurrence }), alreadyCompleted
                    {
                        continue
                    } else if let repeatUntil = activity.repeatUntil, repetition.start > repeatUntil {
                        continue
                    } else {
                        nextActivities.append(occurrence)
                    }
                } else {
                    // Else, calculate the occurrences
                    var occurrenceIndex = 0

                    while let occurrenceDate = repetition.getOccurrenceByNumber(occurrenceIndex) {
                        // Stop if occurrence is beyond repeatUntil
                        if let repeatUntil = activity.repeatUntil, occurrenceDate > repeatUntil {
                            break
                        }

                        let occurrence = HealthActivityOccurrence(date: occurrenceDate, activity: activity)

                        // If it's already completed, skip
                        if let alreadyCompleted = self.completedHealthActivitiesOccurrences[occurrenceDate.endOfDay]?
                            .contains(where: { $0 == occurrence }), alreadyCompleted
                        {
                            occurrenceIndex += 1
                            continue
                        } else if !(self.excludedHealthActivitiesOccurrences[occurrenceDate.endOfDay]?.contains(
                            occurrence
                        ) ?? false) {
                            nextActivities.append(occurrence)
                            break
                        } else {
                            occurrenceIndex += 1
                            continue
                        }

                    }
                }
            }
        }
        return nextActivities
    }
}

// MARK: Pet specializations (Cat, Dog)

class Cat: Pet {
    var bloodType: CatBloodType?
    override init(
        name: String,
        sex: PetSex,
        birthDate: Date,
        breed: String,
        size: PetSize,
        weight: Double,
        allergies: String
    ) {
        super.init(
            name: name,
            sex: sex,
            birthDate: birthDate,
            breed: breed,
            size: size,
            weight: weight,
            allergies: allergies
        )
        self.petType = .cat
    }

    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class Dog: Pet {
    var bloodType: DogBloodType?
    override init(
        name: String,
        sex: PetSex,
        birthDate: Date,
        breed: String,
        size: PetSize,
        weight: Double,
        allergies: String
    ) {
        super.init(
            name: name,
            sex: sex,
            birthDate: birthDate,
            breed: breed,
            size: size,
            weight: weight,
            allergies: allergies
        )
        self.petType = .dog
    }

    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
