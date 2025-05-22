//
//  Untitled.swift
//  MyPetmate
//
//  Created by Jean Pierre on 19/05/25.
//

import UIKit
import Foundation


class PetsViewController: UIViewController {
    
    lazy var newPetButton: NewActivityButton = {
        var button = NewActivityButton()
        button.buttonText = "New Pet"
        return button
    }()
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .Background.primary
        table.dataSource = self
        table.delegate = self
        table.register(PetListTableViewCell.self, forCellReuseIdentifier: PetListTableViewCell.reuseIdentifier)
        return table
        
    }()
    
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
        Persistence.getPetList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PetListTableViewCell.reuseIdentifier, for: indexPath) as? PetListTableViewCell else {
            
            print("Erro")
            return PetListTableViewCell()}
        
        let pet = Persistence.getPetList()[indexPath.item]
        cell.backgroundColor = .Background.primary
        cell.name = pet.name
        cell.sexType = [pet.sex.rawValue, pet.petType.rawValue]
        cell.age = pet.weeksOld
        cell.date = pet.birthDate
        cell.imagePet = " "
        
        return cell
        
    }
}

extension PetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
