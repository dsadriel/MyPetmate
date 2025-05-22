//
//  MockDataViewController.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 21/05/25.
//


import UIKit

class MockDataViewController: UIViewController {
    
    private let addMockDataButton: NewActivityButton = {
        let button = NewActivityButton()
        button.buttonText = "Add Mock Data"
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAddMockDataButton()
    }
    
    private func setupAddMockDataButton() {
        view.addSubview(addMockDataButton)
        NSLayoutConstraint.activate([
            addMockDataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addMockDataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addMockDataButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        addMockDataButton.addTarget(self, action: #selector(addMockDataTapped), for: .touchUpInside)
    }
    
    @objc private func addMockDataTapped() {
        addMockData()
        let alert = UIAlertController(title: "Success", message: "Mock data added!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func addMockData(){
        
        UserDefaults.standard.removeObject(forKey: "myPetmateAppData")
        
        let cat = Cat(
            name: "Nyx",
            sex: .female,
            birthDate: Date(),
            breed: "cat",
            size: .small,
            weight: 2.5,
            allergies: "none"
        )
        cat.pictureName = "cat"

        Persistence.addPet(cat)

        let walkActivity = DailyActivity(
            name: "Walk",
            category: .activity,
            measurementAmount: 20,
            repetitions: [
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 10, minute: 30, second: 59, of: Date())!,
                    interval: .daily
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 15, minute: 15, second: 59, of: Date())!,
                    interval: .daily
                )
            ]
        )

        let runActivity = DailyActivity(
            name: "Run",
            category: .activity,
            measurementAmount: 20,
            repetitions: [
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 10, minute: 30, second: 59, of: Date())!,
                    interval: .weekly
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 15, minute: 15, second: 59, of: Date())!,
                    interval: .weekly
                )
            ]
        )

        let feedCat = DailyActivity(
            name: "Feed",
            category: .feeding,
            measurementAmount: 50,
            repetitions: [
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 10, minute: 30, second: 59, of: Date())!,
                    interval: .daily
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 11, minute: 30, second: 59, of: Date())!,
                    interval: .daily
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 12, minute: 30, second: 59, of: Date())!,
                    interval: .daily
                )
            ]
        )
        
        let giveWater = DailyActivity(
            name: "Give water",
            category: .water,
            measurementAmount: 100,
            repetitions: [
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!,
                    interval: .daily
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!,
                    interval: .daily
                )
            ]
        )

        Persistence.addActivity(walkActivity, to: cat)
        Persistence.addActivity(runActivity, to: cat)
        Persistence.addActivity(feedCat, to: cat)
        Persistence.addActivity(giveWater, to: cat)

        let dog = Dog(
            name: "Caetano Veloso",
            sex: .male,
            birthDate: Date(),
            breed: "dachshund",
            size: .medium,
            weight: 5.2,
            allergies: "unknown"
        )

        Persistence.addPet(dog)

        let feedDog = DailyActivity(
            name: "Feed with kibble",
            category: .feeding,
            measurementAmount: 20,
            repetitions: [
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 15, minute: 30, second: 59, of: Date())!,
                    interval: .daily
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 17, minute: 00, second: 59, of: Date())!,
                    interval: .daily
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 22, minute: 00, second: 59, of: Date())!,
                    interval: .daily
                )
            ]
        )

        let parkWalk = DailyActivity(
            name: "Walk in the Park",
            category: .activity,
            measurementAmount: 20,
            repetitions: [
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 20, minute: 30, second: 59, of: Date())!,
                    interval: .weekly
                ),
                ActivityRepeation(
                    start: Calendar.current.date(bySettingHour: 22, minute: 15, second: 59, of: Date())!,
                    interval: .weekly
                )
            ]
        )

        Persistence.addActivity(feedDog, to: dog)
        Persistence.addActivity(parkWalk, to: dog)

        print(Persistence.getPetList())
        
    }
}
