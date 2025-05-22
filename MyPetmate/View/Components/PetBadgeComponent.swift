import UIKit
import Foundation

class PetBadgeComponent: UICollectionViewCell {
    
    static var reuseIdentifier = "TaskTableViewCell"

    private lazy var imgPet: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var iconImg: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .right
        img.image = UIImage(named: "clipboard")
        img.setContentHuggingPriority(.defaultLow, for: .horizontal)
        img.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return img
    }()
    
    private lazy var petTypeIcon: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .Colors.primary
        return img
        
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headlineRegular
        label.textColor = .Label.card
        return label
    }()
    
    private lazy var nameStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [petTypeIcon, nameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 6
        return stack
    }()
    
    private lazy var activityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .subheadlineRegular
        label.textColor = .Label.card
        return label
    }()
    
    private lazy var dataOfActivityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Label.card
        return label
    }()
    
    private lazy var activityStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [dataOfActivityLabel, activityLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private lazy var infoStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameStack, activityStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stack
        
    }()
    
    private lazy var infoImgStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [imgPet ,infoStack, iconImg])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = 16
        stack.clipsToBounds = true
        return stack
        
    }()
    
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var activityName: String? {
        didSet {
            activityLabel.text = activityName
        }
    }
    
    var imagePet: String? {
        didSet {
            imgPet.image = UIImage(named: imagePet ?? "")
        }
    }
    
    var icon: String? {
        didSet {
            petTypeIcon.image = UIImage(systemName: icon ?? "")
        }
    }
    
    var quantityOfActivity: String? {
        didSet {
            dataOfActivityLabel.text = quantityOfActivity
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        registerForTraitChanges([UITraitUserInterfaceStyle.self], target: self, action: #selector(updateGradient))
        layoutSubviews()
    }
    
    @objc func updateGradient(){
        DispatchQueue.main.async {
            self.infoImgStack.addGradient()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.infoImgStack.addGradient()
            self.imgPet.layer.cornerRadius = self.imgPet.frame.width/2.0
        }
    }
    
}

extension PetBadgeComponent: ViewCodeProtocol {
    func addSubviews() {
        addSubview(infoImgStack)
    }
    
    func setupConstraints() {

        NSLayoutConstraint.activate([
            
            infoImgStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoImgStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            infoImgStack.topAnchor.constraint(equalTo: self.topAnchor),
            infoImgStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            iconImg.heightAnchor.constraint(equalToConstant: 70),

            iconImg.bottomAnchor.constraint(equalTo: infoImgStack.bottomAnchor),
            
            
            imgPet.heightAnchor.constraint(equalToConstant: 70),
            imgPet.widthAnchor.constraint(equalToConstant: 70)

    
        ])
    }
}
