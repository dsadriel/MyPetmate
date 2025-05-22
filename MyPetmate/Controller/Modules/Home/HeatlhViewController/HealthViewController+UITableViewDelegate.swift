//
//  UITableViewDelegate.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

extension HealthViewController: UITableViewDelegate {
    
    func getActivityOccurrence(at indexPath: IndexPath) -> HealthActivityOccurrence {
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
//            self.showDeleteAlert(for: self.getActivityOccurrence(at: indexPath))
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit")
        {[weak self] _, _, completionHandler in
            // MARK: FIX-ME - Open modal
            let alert = UIAlertController(title: "abrir modal de edicao", message: "aa", preferredStyle: .actionSheet)
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
