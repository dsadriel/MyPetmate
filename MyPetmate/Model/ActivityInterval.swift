//
//  ActivityInterval.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import UIKit

enum ActivityInterval {
    case one, daily, weekly, monthly, yearly
    
    func calculateNextOccurence(after date: Date, repeationNumber number: Int = 1) -> Date {
        switch self {
        case .daily:
            return Calendar.current.date(byAdding: .day, value: number, to: date)!
        case .weekly:
            return Calendar.current.date(byAdding: .weekOfYear, value: number, to: date)!
        case .monthly:
            return Calendar.current.date(byAdding: .month, value: number, to: date)!
        case .yearly:
            return  Calendar.current.date(byAdding: .year, value: number, to: date)!
        default:
            return date
        }
    }
}
