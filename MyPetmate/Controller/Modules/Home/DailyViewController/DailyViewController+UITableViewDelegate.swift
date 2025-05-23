//
//  UITableViewDelegate.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

extension DailyViewController: UITableViewDelegate {
    
    func getActivityOccurrence(at indexPath: IndexPath) -> DailyActivityOccurrence {
        return tableRows[indexPath.section][indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HealthDailyHeaderView.reuseIdentifier) as? HealthDailyHeaderView else {
            return UIView()
        }
        
        let category = tableSections[section]
        
        header.titleText = category.title
        header.iconImageName = category.systemImageName
        
        var goalTarget: Int = 0
        var goalProgress: Int = 0

        for item in tableRows[section] {
            if item.isCompleted {
                goalProgress += item.activity.measurementAmount
            }
            goalTarget += item.activity.measurementAmount
        }
        header.goalTarget = "\(goalTarget)\(category.measurementUnit)"
        header.goalProgress = "\(goalProgress)"

        
        return header
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete")
        {[weak self] _, _, completionHandler in
            guard let self else {
                return
            }
            self.showDeleteAlert(for: self.getActivityOccurrence(at: indexPath))
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit")
        {[weak self] _, _, completionHandler in
            // MARK: FIX-ME - Open modal
            let alert = UIAlertController(
                title: "Edit Feature",
                message: "This feature is not implemented yet.",
                preferredStyle: .actionSheet
            )
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alert, animated: true)
            self?.updateDataAndUI()
            completionHandler(true)
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .orange


        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
}


extension DailyViewController {
    func showDeleteAlert(for activityOccurrence: DailyActivityOccurrence) {
            let alert = UIAlertController(
                title: "Are you sure you want to delete the activity?",
                message: nil,
                preferredStyle: .alert
            )
            
            // "Delete activity forever"
            let deleteForever = UIAlertAction(
                title: "Delete activity forever",
                style: .destructive,
            ) { _ in
                Persistence.deleteActivity(activityOccurrence.activity, from: (self.selectedPet)!)
                self.updateDataAndUI()
            }
            
            // "Delete only this time"
            let deleteOnce = UIAlertAction(
                title: "Delete only this time",
                style: .destructive
            ) { _ in
                Persistence.excludeActivityOccourence(activityOccurrence, from: (self.selectedPet)!)
                self.updateDataAndUI()
            }
            
            // Cancel
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteForever)
            alert.addAction(deleteOnce)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
}
