//
//  BirthDatePicker.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

import UIKit

public class BirthDatePicker: UIView {
    
    internal lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Label.primary
        label.font = UIFont.bodyRegular
        //label.textAlignment = .center
        label.text = "Birth Date"
        
        return label
    }()
    
    
    internal lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.tintColor = .Label.primary
        datePicker.backgroundColor = .Background.terciary
        
        return datePicker
    }()
    
    internal lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, datePicker])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        //stackView.spacing = 8
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        //setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(stack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
}
