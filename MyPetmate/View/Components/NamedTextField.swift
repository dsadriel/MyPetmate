//
//  NamedTextField.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

import UIKit

class NamedTextField: UIView {
    
    internal lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label text"
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 22)
        ])
    
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        textField.placeholder = "Placeholder text"
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, textField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
    
        return stack
    }()
    
    private let bottomBorder = CALayer()
    
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var text: String? {
        get {
            textField.text
        }
        set(newText) {
            textField.text = newText
        }
    }
    
    private func setupBorder() {
        bottomBorder.backgroundColor = UIColor.Separator.primary.cgColor
        layer.addSublayer(bottomBorder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupBorder()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        let borderHeight: CGFloat = 0.33
            bottomBorder.frame = CGRect(
                x: 0,
                y: bounds.height - borderHeight,
                width: bounds.width,
                height: borderHeight
            )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16 ),

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}
