
import UIKit
import Foundation

class PetListTableViewCell: UITableViewCell {
    
    static var reuseIdentifier = "PetTableViewCell"

    lazy var petCard: PetCard = {
        var component = PetCard(name: "", sex: "", type: "", birthDate: Date(), imageURL: "")
        component.translatesAutoresizingMaskIntoConstraints = false
        component.name = "Bela"
        component.setSexType(sex: "Female", type: "Cat")
        component.birthDate = Date()
        component.setImage(img: "https://fastly.picsum.photos/id/237/200/300.jpg")
        return component
    }()
    
    
    var name: String? {
        didSet {
            petCard.name = name
        }
    }
    
    var sexType: [String?] {
        set {
            petCard.setSexType(sex: newValue[0] ?? "None", type: newValue[1] ?? "None")
        }
        
        get {
            return [""]
        }
    }
        
    var imagePet: String? {
        set {
            petCard.setImage(img: newValue)
        }
        
        get {
            return ""
        }
    }
    
    
    
    var age: Int? {
        didSet {
            petCard.age = "\(age ?? 0) Years old"
        }
    }
    
    var date: Date? {
        didSet {
            petCard.birthDate = date ?? Date().self
        }
    }
    
    override init(style: PetListTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        DispatchQueue.main.async {
//            self.imgPet.layer.cornerRadius = self.imgPet.frame.width/2.0
//        }

    
    
}

extension PetListTableViewCell: ViewCodeProtocol {
    func addSubviews() {
        self.addSubview(petCard)
    }
    
    func setupConstraints() {

        NSLayoutConstraint.activate([
            
            petCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            petCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            petCard.topAnchor.constraint(equalTo: self.topAnchor),


    
        ])
    }
}
    
