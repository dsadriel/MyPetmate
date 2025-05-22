//
//  SexSelector.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

import UIKit

class SexSelector: UIView {
    
    var selectedSex: Sex? {
        didSet {
            button.setTitle(selectedSex?.rawValue.capitalizingFirstLetter() ?? "Select", for: .normal)
        }
    }
    
    private var sexSelections: [UIAction] {
        Sex.allCases
            .sorted(by: { $0.rawValue < $1.rawValue })
            .map { sex in
                UIAction(title: sex.rawValue.capitalizingFirstLetter()) { [weak self] _ in
                    self?.selectedSex = sex
                }
            }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sex"
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        return label
    }()
    
    lazy var button: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Select"
        config.indicator = .popup
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.menu = UIMenu(title: "Sex",
                             options: .singleSelection,
                             children: sexSelections)
        button.showsMenuAsPrimaryAction = true
        button.tintColor = .Label.secondary
        
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, button])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(stack)
        setupConstraints()
        setupBorder()
    }
    
    private let bottomBorder = CALayer()
    
    private func setupBorder() {
        bottomBorder.backgroundColor = UIColor.Separator.primary.cgColor
        layer.addSublayer(bottomBorder)
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
