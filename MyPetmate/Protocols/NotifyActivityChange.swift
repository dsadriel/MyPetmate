//
//  NotifyActivityChange.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 21/05/25.
//



protocol NotifyActivityChange: AnyObject {
    func didChangeActivity(_ activity: HealthActivity)
    func didChangeActivity(_ activity: DailyActivity)
}
