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
        return UITableViewCell()
    }
}
