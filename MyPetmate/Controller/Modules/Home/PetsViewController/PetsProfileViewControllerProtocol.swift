import Foundation
import UIKit


class PetsProfileViewController: UIViewController {
    
    private let pet: Pet
    
    init(pet: Pet) {
        self.pet = pet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPet))
        navigationItem.title = "Pet Profile"
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func editPet () {
        print()
    }
    
}
