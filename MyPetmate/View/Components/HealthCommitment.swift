//
//  HealthSchedule.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 14/05/25.
//
import UIKit

class HealthCommitment: UIView {
    
    //MARK: initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var isChecked = false

    private lazy var labelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.title3Regular
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .Label.primary
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var roundButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .Unselected.primary
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateView: LabelDateHour = {
        let label = LabelDateHour()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var hourView: LabelDateHour = {
        let label = LabelDateHour()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: details
    private lazy var labelDetails: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .Button.primary
        label.text = "Details"
        label.font = UIFont.bodyRegular
        return label
    }()
    
    private lazy var imageDetails: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .Button.primary
        return imageView
    }()
    
    //MARK: stacks
    private lazy var DatasStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [dateView, hourView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 6
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var detailsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [labelDetails, imageDetails])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 14
        stack.alignment = .center
        stack.axis = .horizontal
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(detailsButtonTap))
            
        stack.addGestureRecognizer(tap)
        return stack
    }()
    
    private lazy var dataAndDetailsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [DatasStack, detailsStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 31
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [roundButton, dataAndDetailsStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var verticalStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [labelView, horizontalStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    
    //MARK:
    func configure(label: String?, dateHour: Date) {
        dateView.configure(isDate: true, date: Date())
        hourView.configure(isDate: false, date: Date())
        labelView.text = label
    }
    
    var checked: () -> Void = {}
    var details: () -> Void = {}
    
    @objc private func handleButtonTap() {
        isChecked.toggle()
        checked()
        updateRadialButton()
    }
    
    func updateRadialButton(){
        let imageName = isChecked ? "circle.fill" : "circle"
        roundButton.setImage(UIImage(systemName: imageName), for: .normal)
        roundButton.tintColor = isChecked ? .Button.primary : .Unselected.primary
    }
    
    @objc private func detailsButtonTap() {
        details()
    }

}

extension HealthCommitment: ViewCodeProtocol {
    func setup(){
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        addSubview(verticalStack)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.heightAnchor.constraint(equalToConstant: 89),
            self.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
        ])
    }
}
