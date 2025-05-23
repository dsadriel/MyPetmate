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
    
            cell.imgPet.image = Persistence.getPetProfilePicture(for: pet)

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPetCollectionViewCell.reuseIdentifier, for: indexPath) as? AddPetCollectionViewCell
            else { fatalError() }
            
            cell.buttonAction = {[weak self] in
                let newPetViewController = NewActivityCategoryController()
                newPetViewController.categories = [PetType.cat, PetType.dog]
                newPetViewController.willCreatePet = true
                newPetViewController.delegate = self
                
                let navigationController: UINavigationController = UINavigationController(rootViewController: newPetViewController)
                navigationController.navigationBar.isHidden = true
                navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
                self?.present(navigationController, animated: true, completion: nil)
                }
            
            return cell
            
        }
    }
    
}

