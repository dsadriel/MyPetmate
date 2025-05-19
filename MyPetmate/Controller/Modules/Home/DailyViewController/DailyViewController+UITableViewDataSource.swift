//
//  DailyViewController+UICollectionViewDataSource.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - UITableViewDataSource

extension DailyViewController: UITableViewDataSource {
    // MARK: Adjust later with real data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseIdentifier, for: indexPath) as? DailyTableViewCell else {
            return UITableViewCell()
        }
        cell.activityText =  (amount: 20, activityName: "Activity Name")
        cell.fractionText = (numerator: "\(indexPath.row + 1)", denominator: "\(indexPath.section + 1)")
        cell.hourConfig = Date()
        cell.isDone = false
        
        return cell
    }
}
