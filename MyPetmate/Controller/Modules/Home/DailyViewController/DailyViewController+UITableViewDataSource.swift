//
//  DailyViewController+UICollectionViewDataSource.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - UITableViewDataSource

extension DailyViewController: UITableViewDataSource {
    func buildSectionsData() -> [DailyCategory] {
        var sections: [DailyCategory] = []
        let tasks: [DailyActivityOccurrence] = selectedPet?.getTodayActivities() ?? []

        for category in DailyCategory.allCases where tasks.contains(where: { $0.activity.category == category }) {
            sections.append(category)
        }
        
        return sections
    }

    func buildRowsData() -> [[DailyActivityOccurrence]]  {
        var rows: [[DailyActivityOccurrence]] = []
        let tasks: [DailyActivityOccurrence] = selectedPet?.getTodayActivities() ?? []

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseIdentifier, for: indexPath) as? DailyTableViewCell else {
            return UITableViewCell()
        }
        
        let occourence = tableRows[indexPath.section][indexPath.row]
        let activity = occourence.activity
        
        cell.activityText = (amount: "\(activity.measurementAmount) \(activity.category.measurementUnit)",
                             activityName: activity.name)
        cell.hourConfig = occourence.date
        cell.isDone = occourence.isCompleted
        cell.action = {
            Persistence.changeActivityOccurrenceCompleteness(occourence, to: !occourence.isCompleted, in: self.selectedPet!)
            self.updateDataAndUI()
        }
        
        return cell
    }
}
