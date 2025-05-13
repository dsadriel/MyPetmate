import UIKit

class TestController: UIViewController {
    
    lazy var component: PetBadgeComponent = {
        var component = PetBadgeComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    lazy var textLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TESTE"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension TestController: ViewCodeProtocol {
    
    func setupConstraints() {
        
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            
        ])
    }
    
    
    func addSubviews() {
        view.addSubview(textLabel)
    }
}
