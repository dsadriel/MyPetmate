//
//  DailyTableViewCell.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 14/05/25.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    // MARK: Identifier
    
    static let reuseIdentifier = "DailyTableViewCell"
    
    // MARK: Subviews
    
    // Checkmark
    private lazy var checkmarkButton: UIButton = {
        
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return button
    }()
    
    // Activity amount
    private lazy var activityAmountLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        
        return label
    }()
    
    // Portion
    private lazy var currentPortionLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.subheadlineRegular
        label.textColor = .Label.primary
        
        return label
    }()
    
    // Time
    private lazy var timeView: LabelDateHour = {
        
        var time = LabelDateHour()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.widthAnchor.constraint(equalToConstant: 88).isActive = true
        time.setContentHuggingPriority(.required, for: .horizontal)
        time.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        
        return time
    }()
    
    // Activity stack
    private lazy var activityStack: UIStackView = {
        
        var stack = UIStackView(arrangedSubviews: [activityAmountLabel, currentPortionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        stack.axis = .vertical
        
        return stack
    }()
    
    //Main stack
    private lazy var mainStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [checkmarkButton, activityStack, timeView])
        stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 16
        
        return stack
    }()
    
    // MARK: Configuration
    
    var isDone = false
    
    func config(isDone: Bool,
                buttonAction: @escaping () -> Void) {
        self.isDone = isDone
        updateCheckmarkStyle()
        self.action = buttonAction
    }
    
    var activityText: (amount: Int, activityName: String)? {
        didSet {
            guard let activityText = activityText else {
                activityAmountLabel.text = nil
                return
            }
            activityAmountLabel.text = "\(activityText.amount) g \(activityText.activityName)"
        }
    }
    
    var hourConfig: Date? {
        didSet {
            guard let hour = hourConfig else { return }
            timeView.configure(isDate: false, date: hour)
        }
    }
    
    var fractionText: (numerator: String, denominator: String)? {
        didSet {
            guard let fraction = fractionText else {
                currentPortionLabel.text = ""
                return
            }
            currentPortionLabel.text = "\(fraction.numerator)/\(fraction.denominator)"
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupCell(){
        self.backgroundColor = .Background.primary
        updateCheckmarkStyle()
    }
    
    // MARK: Button action
    
    var action: () -> Void = { }
    @objc func buttonTapped() {
        action()
        isDone.toggle()
        updateCheckmarkStyle()
    }
    
    func updateCheckmarkStyle(){
        checkmarkButton.setImage(UIImage(systemName: isDone ? "checkmark.circle.fill" : "circle") , for: .normal)
        checkmarkButton.tintColor = isDone ? .Button.primary : .Unselected.primary
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainStack)
        setupConstraints()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
