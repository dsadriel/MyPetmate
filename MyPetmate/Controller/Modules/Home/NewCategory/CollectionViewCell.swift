//
//  CollectionViewCell.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 19/05/25.
//
import UIKit
class CategoryAndAnimalCell: UICollectionViewCell {
    let component = CategoryAndAnimal()
    var onTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(component)
        component.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: contentView.topAnchor),
            component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        component.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
          onTap?()
      }

    func configure(with label: LabelRepresentable) {
        component.configure(label: label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
