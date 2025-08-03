//
//  Untitled.swift
//  MyPetmate
//
//  Created by Jean Pierre on 19/05/25.
//

import UIKit
import Foundation


extension PetListViewController: ViewCodeProtocol {

    func addSubviews() {
        view.addSubview(newPetButton)
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
    }
    
    func setupConstraints() {
        view.backgroundColor = .Background.primary
        NSLayoutConstraint.activate([
            newPetButton.heightAnchor.constraint(equalToConstant: 50),
            newPetButton.topAnchor.constraint(equalTo: view.firstBaselineAnchor, constant: 160),
            newPetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            newPetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: newPetButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo:  newPetButton.bottomAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
