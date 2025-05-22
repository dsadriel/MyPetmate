import UIKit

class TestController: UIViewController {    
    lazy var component: PetBadgeComponent = {
        var component = PetBadgeComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.imagePet = "dog"
        component.name = "Belinha"
        component.icon = "dog.circle.fill"
        component.activityName = "Daily activities"
        component.quantityOfActivity = "2/10"
        return component
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .Background.primary
    }
}

extension TestController: ViewCodeProtocol {
    
    func setupConstraints() {
        
       NSLayoutConstraint.activate([
            component.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            component.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            component.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            

        ])
    }
    
    
    func addSubviews() {
        view.addSubview(component)

    }
}
