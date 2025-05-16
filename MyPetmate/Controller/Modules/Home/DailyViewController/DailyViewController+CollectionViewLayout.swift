//
//  DailyViewController+CollectionViewLayout.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

// MARK: - buildPetSelectorLayout
extension DailyViewController {
    func buildPetSelectorLayout() -> Layout {

        let itemSize = Size(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = Item(layoutSize: itemSize)
        
        let groupSize = Size(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(103.0))
        let group = Group.horizontal(layoutSize: groupSize, subitems: [item])
                
        let section = Section(group: group)
        section.interGroupSpacing = 8.0
        section.contentInsets = Edges(top: 0, leading: 16.0, bottom: 0, trailing: 16.0)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return Layout(section: section)
    }
}
