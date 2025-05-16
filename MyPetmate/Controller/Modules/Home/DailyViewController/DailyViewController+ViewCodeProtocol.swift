//
//  DailyViewController+ViewCodeProtocol.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - ViewCodeProtocol

extension DailyViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(newActivityButton)
        view.addSubview(petSelectorCollectionView)
        view.addSubview(taskTableView)
    }
    
    func setupConstraints() {
        newActivityButton.activateLeadingPaddingConstrains(to: view)
        taskTableView.activateLeadingPaddingConstrains(to: view)
        
        NSLayoutConstraint.activate([
            newActivityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            newActivityButton.heightAnchor.constraint(equalToConstant: 50),
            
            petSelectorCollectionView.topAnchor.constraint(equalTo: newActivityButton.bottomAnchor, constant: 16),
            petSelectorCollectionView.heightAnchor.constraint(equalToConstant: 103),
            
            petSelectorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            petSelectorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            taskTableView.topAnchor.constraint(equalTo:  petSelectorCollectionView.bottomAnchor, constant: 16),
            taskTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
