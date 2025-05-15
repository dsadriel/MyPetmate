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
    
    //MARK: view inteira
    lazy var newDate: HealthCommitment = {
        let view = HealthCommitment()
        view.configure(label: nil, dateHour: Date())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: parte da view
    lazy var date: LabelDateHour = {
        let label = LabelDateHour()
        label.configure(isDate: true, date: Date())
        return label
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
            
            newDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            newDate.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
            newDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            newDate.heightAnchor.constraint(equalToConstant: 34),
            newDate.widthAnchor.constraint(equalToConstant: 123),
            
//            date.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
//            date.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    
    func addSubviews() {
        view.addSubview(textLabel)
//        view.addSubview(date)
        view.addSubview(newDate)
    }
}
