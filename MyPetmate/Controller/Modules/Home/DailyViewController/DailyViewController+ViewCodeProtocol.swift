//
//  DailyViewController+ViewCodeProtocol.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

extension DailyViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(newActivityButton)
        view.addSubview(petListCollectionView)
        view.addSubview(taskTableView)
    }
    
    func setupConstraints() {
        newActivityButton.activateLeadingPaddingConstrains(to: view)
        petListCollectionView.activateLeadingPaddingConstrains(to: view)
        taskTableView.activateLeadingPaddingConstrains(to: view)
        
        NSLayoutConstraint.activate([
            newActivityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            newActivityButton.heightAnchor.constraint(equalToConstant: 50),
            
            petListCollectionView.topAnchor.constraint(equalTo: newActivityButton.bottomAnchor, constant: 16),
            petListCollectionView.heightAnchor.constraint(equalToConstant: 103),
            
            taskTableView.topAnchor.constraint(equalTo: petListCollectionView.bottomAnchor, constant: 16),
            taskTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
