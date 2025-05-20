//
//  NewActivityButton.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 13/05/25.
//

import UIKit

class NewActivityButton: UIButton {
    
    // MARK: - Setup
    private lazy var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Activity"
        label.font = UIFont.bodyRegular
        label.textColor = .Background.primary
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private lazy var icon: UIImageView = {
        var icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "plus")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .Background.primary
        return icon
    }()
    
    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [icon, label])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()

    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .Button.primary
        layer.cornerRadius = 12
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    var buttonText: String? {
        didSet {
            label.text = buttonText
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        addSubview(stack)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

