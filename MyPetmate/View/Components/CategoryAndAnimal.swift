//
//  CategoryAndAnimal.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 15/05/25.
//
import UIKit

class CategoryAndAnimal: UIButton {
    
    lazy var imageLabel: UIImageView = {
        let imageLabel = UIImageView()
        imageLabel.contentMode = .scaleAspectFit
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.tintColor = .Colors.primary
        return imageLabel
    }()
    
    lazy var labelView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .Colors.primary
        label.font = .title3Regular
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageLabel, labelView])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    
    func configure(label: LabelRepresentable){
        setup()
        labelView.text = label.title
        imageLabel.image = UIImage(systemName: label.systemImageName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateGradient()
        registerForTraitChanges([UITraitUserInterfaceStyle.self], target: self, action: #selector(updateGradient))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateGradient(){
        DispatchQueue.main.async {
            self.addGradient()
        }
    }
}


extension CategoryAndAnimal: ViewCodeProtocol {
    func setup() {
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        addSubviews()
        setupConstraints()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self], target: self, action: #selector(updateGradient))

    }
    func addSubviews() {
        self.addSubview(stackView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
