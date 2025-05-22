//
//  Untitled.swift
//  MyPetmate
//
//  Created by Jean Pierre on 19/05/25.
//

import UIKit
import Foundation


class PetsViewController: UIViewController {
    
    lazy var newPetButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" New Pet", for: .normal)
        button.titleLabel?.font = UIFont(name: "SfPro", size: 17)
        button.setTitleColor(.Label.default, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .Button.primary
        button.tintColor = .Label.default
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .Background.primary
        table.dataSource = self
        table.register(PetListTableViewCell.self, forCellReuseIdentifier: PetListTableViewCell.reuseIdentifier)
        return table
        
    }()
    
    var rows: [Pet] = [Pet(name: "Belinha", sex: "Female", breed: "Dog", type: "Dog", size: "Small", weight: 8, bloodType: "A", allergies: ["None"], birthDate: Date(), weeksOld: 6, documents: ["238945892"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let title = "Pets"
        
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}

extension PetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PetListTableViewCell.reuseIdentifier, for: indexPath) as? PetListTableViewCell else {
            
            print("Erro")
            return PetListTableViewCell()}
        
        cell.backgroundColor = .Background.primary
        cell.name = rows[0].name
        cell.sexType = [rows[0].sex, rows[0].type]
        cell.age = rows[0].weeksOld
        cell.date = rows[0].birthDate
        cell.imagePet = " "
        
        return cell
        
    }
    
    
}

//extension PetsViewController: UITableViewDelegate {
//    
//}
