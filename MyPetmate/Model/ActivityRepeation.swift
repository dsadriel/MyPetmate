//
//  ActivityRepeation.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

struct ActivityRepeation: Codable {
    let start: Date
    let interval: ActivityInterval
    
    func getOccurrenceByNumber(_ number: Int) -> Date? {
        interval.calculateNextOccurence(after: self.start, repeationNumber: number)
    }
}
