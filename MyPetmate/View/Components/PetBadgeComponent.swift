
import UIKit
import Foundation

class PetBadgeComponent: UIView {
    
    lazy var imgPet: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    lazy var petTypeIcon: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
        
    }()
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [petTypeIcon, nameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var activityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dataOfActivityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [dataOfActivityLabel, activityLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.backgroundColor = .green
        return stack
    }()
    
    
    lazy var infoStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameStack, activityStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .blue
        stack.alignment = .leading
        return stack
        
    }()
    
    lazy var mainStack: UIStackView = {
        
        var stack = UIStackView(arrangedSubviews: [imgPet, infoStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fill
        stack.backgroundColor = .yellow
        return stack
    }()
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var imagePet: String? {
        didSet {
            imgPet.image = UIImage(named: imagePet ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        imgPet.layer.cornerRadius = imgPet.frame.width / 2
    }
}

extension PetBadgeComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
    }
    
    func setupConstraints() {
        self.addGradient()
        NSLayoutConstraint.activate([
            
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -16),
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            
            
            imgPet.heightAnchor.constraint(equalToConstant: 70),
            imgPet.widthAnchor.constraint(equalToConstant: 70),
            imgPet.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16.5),
            imgPet.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: -20),
            imgPet.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 8),
            
        ])
    }
}
