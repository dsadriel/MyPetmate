import UIKit
import Foundation

class AddPetCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = "AddPetCollectionViewCell"

    private lazy var icon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "plus")
        image.tintColor = .Button.primary
        image.isUserInteractionEnabled = false
        return image
    }()
    
    private lazy var button: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 21
        button.backgroundColor = .Button.secondary
        button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
        return button
    }()
    
    var buttonAction: () -> Void = {}
    
    @objc func handleButtonAction() {
        buttonAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension AddPetCollectionViewCell: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    func addSubviews() {
        self.addSubview(button)
        self.addSubview(icon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            icon.widthAnchor.constraint(equalToConstant: 46),
            icon.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            icon.topAnchor.constraint(equalTo: button.topAnchor),
            icon.bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])
    }
    
}
