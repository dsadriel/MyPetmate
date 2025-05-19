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
    
    lazy var button: CategoryAndAnimal = {
        let view = CategoryAndAnimal()
        view.configure(label: healthCategory.medication)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
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
            
            button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 103),
            button.widthAnchor.constraint(equalToConstant: 173),

        ])
    }
    
    
    func addSubviews() {
        view.addSubview(textLabel)
        view.addSubview(button)
    }
}
