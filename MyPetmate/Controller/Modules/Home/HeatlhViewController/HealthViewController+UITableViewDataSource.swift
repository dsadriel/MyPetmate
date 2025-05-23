//
//  DailyViewController+UICollectionViewDataSource.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - UITableViewDataSource

extension HealthViewController: UITableViewDataSource {
    func buildSectionsData() -> [HealthCategory] {
        var sections: [HealthCategory] = []
        let tasks: [HealthActivityOccurrence] = selectedPet?.getNextHealthActivities() ?? []

        for category in HealthCategory.allCases where tasks.contains(where: { $0.activity.category == category }) {
            sections.append(category)
        }
        
        return sections
    }

    func buildRowsData() -> [[HealthActivityOccurrence]]  {
        var rows: [[HealthActivityOccurrence]] = []
        let tasks: [HealthActivityOccurrence] = selectedPet?.getNextHealthActivities() ?? []

        for sectionCategory in tableSections {
            rows.append(tasks.filter { $0.activity.category == sectionCategory })
        }
        return rows
    }

    func buildTableData() {
        petList = Persistence.getPetList()
        tableSections = buildSectionsData()
        tableRows = buildRowsData()
    }

    
    
    // MARK: Adjust later with real data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableRows[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HealthCommitmentTableViewCell.reuseIdentifier, for: indexPath) as? HealthCommitmentTableViewCell else {
            return UITableViewCell()
        }
        
        let occourence = tableRows[indexPath.section][indexPath.row]
        let activity = occourence.activity
        
        cell.configure(label: activity.name, dateHour: occourence.date)
        print(occourence.isCompleted)
        cell.isChecked = occourence.isCompleted
        cell.updateRadialButton()
        cell.checked = {
            Persistence.changeActivityOccurrenceCompleteness(occourence, to: !occourence.isCompleted, in: self.selectedPet!)
            cell.isChecked = !occourence.isCompleted
            cell.updateRadialButton()
            
            // Wait 1 second before updating UI
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.updateDataAndUI()
            }
        }


//        cell.activityText = (amount: "\(activity.measurementAmount)",
//                             activityName: activity.name)
//        cell.configure(isDate: true, date: occourence.date)
//        cell.isDone = occourence.isCompleted
//        cell.action = {
//            Persistence.changeActivityOccurrenceCompleteness(occourence, to: !occourence.isCompleted, in: self.selectedPet!)
//            cell.updateCheckmarkStyle()
//            
////            self.updateDataAndUI()
//        }
//        
        return cell
    }
}
