//
//  PetCard.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 13/05/25.
//
import UIKit

class PetCard: UIView {
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 18)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 900
        return imageView
    }()
    
    private let petWithoutPhoto: UIImageView = {
        var imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 14)
        let image = UIImage(systemName: "pawprint.circle", withConfiguration: configuration)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .Label.primary
        nameLabel.font = UIFont.title2Emphasized
        return nameLabel
    }()
    
    private let sexLabel: UILabel = {
        let sexLabel = UILabel()
        sexLabel.font = .systemFont(ofSize: 15, weight: .bold)
        sexLabel.translatesAutoresizingMaskIntoConstraints = false
        sexLabel.textColor = .Label.primary
        sexLabel.font = UIFont.subheadlineEmphasized
        return sexLabel
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 15, weight: .bold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .Label.primary
        dateLabel.font = UIFont.subheadlineRegular
        return dateLabel
    }()
    
    private let yearsLabel: UILabel = {
        let yearsLabel = UILabel()
        yearsLabel.font = .systemFont(ofSize: 15, weight: .bold)
        yearsLabel.translatesAutoresizingMaskIntoConstraints = false
        yearsLabel.textColor = .Label.primary
        yearsLabel.font = UIFont.subheadlineEmphasized
        return yearsLabel
    }()
    
    //MARK: years + birth date stack
    private lazy var yearsBirthStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [yearsLabel, dateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    
    //MARK: check full profile button
    private let fullProfileView: UIView = {
        let button = UIView()
        button.layer.cornerRadius = 15 //precisei mudar aqui pq se seguir o figma fica muuuuuito diferente
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .Button.primary
        return button
    }()
    
    private lazy var checkProfileLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.text = "Check Full Profile"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .Background.primary
        nameLabel.font = UIFont.subheadlineRegular
        return nameLabel
    }()
    
    private lazy var checkProfileImage: UIImageView = {
        var imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 14)
        let paw = UIImage(systemName: "pawprint.fill", withConfiguration: configuration)
        imageView.contentMode = .scaleAspectFit
        imageView.image = paw
        imageView.tintColor = .Background.primary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackCheckProfile: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [checkProfileImage, checkProfileLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 3
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    //MARK: stacks gerais
    private lazy var dataStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameLabel, sexLabel, yearsBirthStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.alignment = .leading
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let horizontalStack = UIStackView()
        return horizontalStack
    }()

    
    init(name: String, sex: String, type: String, birthDate: Date, imageURL: String?) {
        super.init(frame: .zero)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
        self.addGestureRecognizer(tap)

        
        self.addGradient()
        self.backgroundColor = .black
        addSubview(button)
        addSubview(dataStackView)
        addSubview(imageView)
        
        addSubview(fullProfileView)
        fullProfileView.addSubview(stackCheckProfile)
        
        dataStackView.addArrangedSubview(fullProfileView)
        
        addSubview(horizontalStack)
        button.addSubview(imageURL != nil ? imageView : petWithoutPhoto)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: birthDate)
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        let years = ageComponents.year ?? 0
        let yearsString = "\(years) years old"
        
        nameLabel.text = name
        sexLabel.text = sex + " " + type
        yearsLabel.text = yearsString

        
        if let imageURL {
            
            if  imageURL == "" || imageURL == " " {
                imageView.image = UIImage(systemName: "pawprint.circle")
            } else {
                
                self.imageView.image = UIImage(named: imageURL)
            }
        }
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 20
        horizontalStack.alignment = .center
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.addArrangedSubview(imageView)
        horizontalStack.addArrangedSubview(dataStackView)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 122),
            imageView.heightAnchor.constraint(equalToConstant: 122),
                        
            
            horizontalStack.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
            horizontalStack.topAnchor.constraint(equalTo: button.topAnchor, constant: 12),
            horizontalStack.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -12),
            
            checkProfileImage.widthAnchor.constraint(equalToConstant: 20),
            checkProfileImage.heightAnchor.constraint(equalToConstant: 20),
            
            fullProfileView.widthAnchor.constraint(equalToConstant: 163),
            fullProfileView.heightAnchor.constraint(equalToConstant: 28),
            
            stackCheckProfile.centerXAnchor.constraint(equalTo: fullProfileView.centerXAnchor),
            stackCheckProfile.centerYAnchor.constraint(equalTo: fullProfileView.centerYAnchor),

            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            self.addGradient()
            
            layer.cornerRadius = 16
            layer.masksToBounds = true
        
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
        }
    
    @objc private func handleButtonTap() {
        print("pressed!")
    }
    
    
    var name: String? {
        set {
            nameLabel.text = newValue
        }
        get {
            return nameLabel.text
        }
        }
    
    var sexType: String? {
        
        get {
            return sexLabel.text
        }
        }
    
    func setSexType(sex:String, type:String)
    {
        sexLabel.text = sex + " " + type
    }
    
    var birthDate: Date? {
        set {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            dateLabel.text = formatter.string(from: newValue ?? Date())
        }
        
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            return formatter.date(from: dateLabel.text ?? "")
        }
        }
    
    func setImage(img: String?) {
        
        if let img {
            
            if img == "" || img == " " {
                imageView.image = UIImage(systemName: "pawprint.circle")
            } else {
                
                self.imageView.image = UIImage(named: img)
            }
        }
    }
    
    
    
}

