import Foundation
import UIKit


extension PetsProfileViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(imgStack)
    }
    
    func setupConstraints() {
        view.backgroundColor = .Background.primary
        NSLayoutConstraint.activate([
            
            imgStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            imgStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -99),
            imgStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            
            petImage.heightAnchor.constraint(equalToConstant: 79.5),
            petImage.widthAnchor.constraint(equalToConstant: 79.5),
            
        ])
    }
    
    
    
    
}
