//
//  DailyViewController+ViewCodeProtocol.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - ViewCodeProtocol

extension HealthViewController: ViewCodeProtocol {
    func setup() {
        petList = Persistence.getPetList()
        selectedPetIndex = 1 // MARK: FIX-ME
        buildTableData()
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(petSelectorCollectionView)
        view.addSubview(taskTableView)
        view.addSubview(newActivityButton)
        view.addSubview(emptyStateView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newActivityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            newActivityButton.heightAnchor.constraint(equalToConstant: 50),
            newActivityButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            newActivityButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            petSelectorCollectionView.topAnchor.constraint(equalTo: newActivityButton.bottomAnchor, constant: 16),
            petSelectorCollectionView.heightAnchor.constraint(equalToConstant: 103),
            
            petSelectorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            petSelectorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            taskTableView.topAnchor.constraint(equalTo:  petSelectorCollectionView.bottomAnchor, constant: 16),
            taskTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            taskTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            emptyStateView.topAnchor.constraint(equalTo:  petSelectorCollectionView.bottomAnchor, constant: -32),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
