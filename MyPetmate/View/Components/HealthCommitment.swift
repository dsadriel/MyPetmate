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
    
    
    //MARK:
    func configure(label: String?, dateHour: Date) {
        dateView.configure(isDate: true, date: Date())
        hourView.configure(isDate: false, date: Date())
    }
    
    var action: () -> Void = {}
    
    @objc private func handleButtonTap() {
        action()
    }
    
    func updateRadialButton(){
        let imageName = isChecked ? "circle.fill" : "circle"
        roundButton.setImage(UIImage(systemName: imageName), for: .normal)
        roundButton.tintColor = isChecked ? .Button.primary : .Unselected.primary
    }

}

extension HealthCommitment: ViewCodeProtocol {
    func setup(){
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        addSubview(horizontalStack)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
//            self.widthAnchor.constraint(equalToConstant: 393),
//            self.heightAnchor.constraint(equalToConstant: 60),
//
            roundButton.widthAnchor.constraint(equalToConstant: 22),
            roundButton.heightAnchor.constraint(equalToConstant: 22)
            
        ])
    }
}
