//
//  UICollectionViewDataSource.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - UICollectionViewDataSource

// MARK: Adjust later with real data
let numberOfPets = 3

extension DailyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfPets+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < numberOfPets {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetBadgeComponent.reuseIdentifier, for: indexPath) as? PetBadgeComponent
            else { fatalError() }
            
            cell.name = "Pet \(indexPath.item + 1)"
            cell.activityName = "Atividade"
            cell.quantityOfActivity = "10"
            cell.icon = "person.circle"
            //            cell.imagePet = set pet profile picture
            return cell
        } else {
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
            emptyCell.backgroundColor = .clear // update to add button
            return emptyCell
        }
    }
    
}

