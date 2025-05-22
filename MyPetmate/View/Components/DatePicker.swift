
//
//  DatePicker.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

import UIKit

public class DatePicker: UIView {
    
    // MARK: Subviews
    internal lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Label.primary
        label.font = UIFont.bodyRegular
        label.text = "Date label"
        return label
    }()
    
    internal lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.tintColor = .Label.primary
        datePicker.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        datePicker.layer.cornerRadius = 12
        
        return datePicker
    }()
    
    internal lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, datePicker])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        return stack
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Configuration
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    var hasHour: Bool = false {
        didSet {
            if hasHour {
                datePicker.datePickerMode = .dateAndTime
                //datePicker.locale = Locale.init(identifier: "en")
            }
        }
    }
    
    private let bottomBorder = CALayer()
    
    private func setupBorder() {
        bottomBorder.backgroundColor = UIColor.Separator.primary.cgColor
        layer.addSublayer(bottomBorder)
    }
    
    public override func layoutSubviews() {
            super.layoutSubviews()
        let borderHeight: CGFloat = 0.33
            bottomBorder.frame = CGRect(
                x: 0,
                y: bounds.height - borderHeight,
                width: bounds.width,
                height: borderHeight
            )
    }
    
    func addSubviews() {
        self.addSubview(stack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            datePicker.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            datePicker.heightAnchor.constraint(equalToConstant: 34),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
}
