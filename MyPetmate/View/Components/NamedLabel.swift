//
//  NamedTextField.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

import UIKit

class NamedLabel: UIView {
    
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label text"
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 22)
        ])
    
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var valueImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.setContentHuggingPriority(.defaultLow, for: .horizontal)
        img.contentMode = .right
        img.tintColor = .Button.primary

        return img
    }()
    

    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [keyLabel, valueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
    
        return stack
    }()
    
    private let bottomBorder = CALayer()
    
    var key: String? {
        didSet {
            keyLabel.text = key
        }
    }
    
    var value: String? {
        get {
            valueLabel.text
        }
        set(newText) {
            valueLabel.text = newText
        }
    }
    
    var img: UIImage? {
        
        didSet {
                valueImage.image = img
                
                // Remove o valueLabel se estiver no stack
                if stackView.arrangedSubviews.contains(valueLabel) {
                    stackView.removeArrangedSubview(valueLabel)
                    valueLabel.removeFromSuperview()

                    
                }
                
                // Adiciona a imagem, se ainda não estiver
                if !stackView.arrangedSubviews.contains(valueImage) {
                    stackView.addArrangedSubview(valueImage)
                }
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


            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                               
            
        ])
    }

}
