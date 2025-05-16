//
//  UITableViewDelegate.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

extension DailyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HealthDailyHeaderView.reuseIdentifier) as? HealthDailyHeaderView else {
            return UIView()
        }
        
        // MARK: - Adjust later with real data
        header.titleText = "Section \(section)"
        if Int.random(in: 1...2) == 1 {
            let randomTarget = Int.random(in: 2...5) * 100
            let randomProgress = Int(Double(randomTarget) * Double(Int.random(in: 1...9))/10.0)
            header.goalTarget = "\(randomTarget)"
            header.goalProgress = "\(randomProgress)"
        }
        
        return header
    }
}
