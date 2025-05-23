import Foundation
import UIKit


extension PetsProfileViewController: ViewCodeProtocol {
    func addSubviews() {
        view.addSubview(imgStack)
        view.addSubview(componentsStack)
//        view.addSubview(vaccinesComponent)
    }
    
    func setupConstraints() {
        view.backgroundColor = .Background.primary
        NSLayoutConstraint.activate([
            
            imgStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            imgStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -99),
            imgStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            
            petImage.heightAnchor.constraint(equalToConstant: 79.5),
            petImage.widthAnchor.constraint(equalToConstant: 79.5),
            
            componentsStack.topAnchor.constraint(equalTo: imgStack.bottomAnchor, constant: 16),
            componentsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            componentsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
//            vaccinesComponent.topAnchor.constraint(equalTo: componentsStack.bottomAnchor, constant: 24),
//            vaccinesComponent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            vaccinesComponent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
    
    
    
    
}
