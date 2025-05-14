//
//  Hour.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 14/05/25.
//
import UIKit

struct Hour {
    let hour: Int
    let minute: Int
}

struct HourManager {
    let date: Date

    var hour: Int {
        Calendar.current.component(.hour, from: date)
    }

    var minute: Int {
        Calendar.current.component(.minute, from: date)
    }
    
    func toString() -> String {
        if(hour > 11 && minute > 59){
            String(format: "%02d:%02d PM", hour, minute)
        }else{
            String(format: "%02d:%02d AM", hour, minute)
        }
    }
}
