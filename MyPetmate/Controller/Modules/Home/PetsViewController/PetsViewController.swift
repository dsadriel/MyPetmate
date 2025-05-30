//
//  Untitled.swift
//  MyPetmate
//
//  Created by Jean Pierre on 19/05/25.
//

import UIKit
import Foundation


class PetsViewController: UIViewController {
    
    var petList: [Pet] = Persistence.getPetList()
    
    lazy var newPetButton: NewActivityButton = {
        var button = NewActivityButton()
        button.buttonText = "New Pet"
        button.addTarget(self, action: #selector(openNewPetModal), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .Background.primary
        table.delegate = self
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
    
    @objc func openNewPetModal() {
        let newPetViewController = NewActivityCategoryController()
        newPetViewController.categories = [PetType.cat, PetType.dog]
        newPetViewController.willCreatePet = true
        newPetViewController.delegate = self
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: newPetViewController)
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        self.present(navigationController, animated: true, completion: nil)
    }
    
    lazy var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.template = .noPetsRegistered
        return view
    }()
}

extension PetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = petList.isEmpty
        emptyStateView.isHidden = !petList.isEmpty
        
        return petList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PetListTableViewCell.reuseIdentifier, for: indexPath) as? PetListTableViewCell else {
            
            print("Erro")
            return PetListTableViewCell()}
        
        let pet = petList[indexPath.item]
        cell.backgroundColor = .Background.primary
        cell.name = pet.name
        cell.sexType = [pet.sex.rawValue, pet.petType.rawValue]
        cell.ageString = pet.ageString
        cell.date = pet.birthDate
        cell.petProfilePicture = Persistence.getPetProfilePicture(for: pet)
        return cell
        
    }
}

extension PetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        let selectedPet = petList[indexPath.row]
        
        let petProfileVc = PetsProfileViewController()
        
        petProfileVc.petLabel.text = selectedPet.name
        petProfileVc.sexComponent.value = selectedPet.sex.rawValue
        petProfileVc.breedComponent.value = selectedPet.breed
        petProfileVc.sizeComponent.value = selectedPet.size.rawValue
        petProfileVc.weightComponent.value = "\(selectedPet.weight)"
        petProfileVc.allergiesComponent.value = selectedPet.allergies
        petProfileVc.petImage.image = Persistence.getPetProfilePicture(for: selectedPet)

        petProfileVc.bloodTypeComponent.value = (selectedPet as? Cat)?.bloodType?.rawValue ?? (selectedPet as? Dog)?.bloodType?.rawValue ?? ""
    
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        petProfileVc.birthDateComponent.value  = formatter.string(from: selectedPet.birthDate)
        
        
        
        
        navigationController?.pushViewController(petProfileVc, animated: true)
    }
}


extension PetsViewController: CanReloadView {
    func reloadView() {
        petList = Persistence.getPetList()
        tableView.reloadData()
    }
}
