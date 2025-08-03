import Foundation
import UIKit


class PetProfileViewController: UIViewController {
    
    lazy var petImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "pawprint.circle")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 42
        image.clipsToBounds = true
        return image
    }()
    
    lazy var petLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pet name"
        label.font = .title1Emphasized
        return label
    }()
    
    lazy var imgStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [petImage, petLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    lazy var sexComponent: NamedLabel = {
        var component = NamedLabel()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.key = "Sex"
        component.value = "?"
        return component
        
    }()
    
    lazy var birthDateComponent: NamedLabel = {
        var component = NamedLabel()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.key = "Birth Date"
        component.value = "?"
        return component
        
    }()
    
    lazy var breedComponent: NamedLabel = {
        var component = NamedLabel()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.key = "Breed"
        component.value = "?"
        return component
        
    }()
    
    lazy var sizeComponent: NamedLabel = {
        var component = NamedLabel()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.key = "Size"
        return component
        
    }()
    
    lazy var weightComponent: NamedLabel = {
        var component = NamedLabel()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.key = "Weight"
        component.value = "?"
        return component
        
    }()
    
    lazy var bloodTypeComponent: NamedLabel = {
        var component = NamedLabel()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.key = "Blood Type"
        component.value = "?"
        return component
        
    }()
    
    lazy var allergiesComponent: NamedLabel = {
        var component = NamedLabel()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.key = "Allergies"
        component.value = "?"
        return component
        
    }()
    
    lazy var componentsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [sexComponent, birthDateComponent, breedComponent, sizeComponent, weightComponent, bloodTypeComponent, allergiesComponent])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        return stack
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPet))
        button.tintColor = .Button.primary
        navigationItem.title = "Pet Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = button
        navigationController?.navigationBar.tintColor = .Button.primary
        setup()
    }
    
    @objc func editPet () {
        print()
    }
}
