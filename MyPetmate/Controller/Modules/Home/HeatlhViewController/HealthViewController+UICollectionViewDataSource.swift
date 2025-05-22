//
//  UICollectionViewDataSource.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension HealthViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petList.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item < Persistence.getPetList().count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetBadgeComponent.reuseIdentifier, for: indexPath) as? PetBadgeComponent
            else { fatalError() }
            
            let pet = petList[indexPath.item]
            cell.name = pet.name
            cell.activityName = "Health Schedules"
            cell.quantityOfActivity = "\(pet.healthActivities.count)"
                
            cell.icon = pet.petType.systemImageName
    
            cell.imagePet = "dog"
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPetCollectionViewCell.reuseIdentifier, for: indexPath) as? AddPetCollectionViewCell
            else { fatalError() }
            
            cell.buttonAction = {
                print(#function)
            }
            
            return cell
            
        }
    }
    
}

