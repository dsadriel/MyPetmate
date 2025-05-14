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
    
//    lazy var date: UIView = {
////        let view = LabelDateHour(isDate: true, hour: nil, date: Date())
//        let view = LabelDateHour(isDate: true, date: Date())
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//        
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
            
//            date.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 56),
////            date.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 214),
//            date.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
////            date.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
//            date.heightAnchor.constraint(equalToConstant: 34),
//            date.widthAnchor.constraint(equalToConstant: 123),
        ])
    }
    
    
    func addSubviews() {
        view.addSubview(textLabel)
//        view.addSubview(date)
    }
}
