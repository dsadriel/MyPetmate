//
//  HeaderNewActivity.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 20/05/25.
//
import UIKit
class HeaderNewActivity: UIView {
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.Button.primary, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.bodyRegular
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var newTaskLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .Label.primary
        label.font = UIFont.bodySemibold
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.Button.primary, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.bodyRegular
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(label: String) {
        super.init(frame: .zero)
        setup()
        newTaskLabel.text = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderNewActivity: ViewCodeProtocol {
    func setup(){
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        self.addSubview(cancelButton)
        self.addSubview(newTaskLabel)
        self.addSubview(saveButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveButton.centerYAnchor.constraint(equalTo: centerYAnchor),
 
            newTaskLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            newTaskLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    
}
