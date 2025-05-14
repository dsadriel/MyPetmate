import UIKit

class TestController: UIViewController {
    
    lazy var textLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TESTE"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
//    lazy var petCard: PetCard = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd"
//        let date = formatter.date(from: "2020/05/01") ?? Date()
//
//        let card = PetCard(name: "Belinha", sex: "Female", type: "Dog", birthDate: date, imageURL: "https://adimax.com.br/wp-content/uploads/2022/05/cuidados-filhote-de-cachorro.jpg")
//        card.translatesAutoresizingMaskIntoConstraints = false
//        return card
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension TestController: ViewCodeProtocol {
    
    func setupConstraints() {
        
        view.backgroundColor = .Background.primary
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
//            petCard.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
//            petCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            petCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            petCard.heightAnchor.constraint(equalToConstant: 146)
        ])
    }
    
    
    func addSubviews() {
        view.addSubview(textLabel)
//        view.addSubview(petCard)
    }
}
