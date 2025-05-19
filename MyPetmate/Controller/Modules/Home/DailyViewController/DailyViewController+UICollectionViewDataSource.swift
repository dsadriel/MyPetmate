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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetBadgeComponent.reuseIdentifier, for: indexPath) as? PetBadgeComponent
           else { fatalError() }
        
        if indexPath.item < numberOfPets {
            cell.backgroundColor = .Button.primary
        } else {
            cell.backgroundColor = .Button.secondary
        }
        return cell
    }
}
