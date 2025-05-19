//
//  ActivityRepeation.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

struct ActivityRepeation {
    let start: Date
    let interval: ActivityInterval
    
    func calculateNextOccurence(repeationNumber number: Int = 1) -> Date {
        interval.calculateNextOccurence(after: self.start, repeationNumber: number)
    }
}
