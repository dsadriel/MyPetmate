//
//  DailyViewController.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

class HealthViewController: UIViewController {
    
    var petList: [Pet] = Persistence.getPetList()
    var tableSections: [HealthCategory] = []
    var tableRows: [[HealthActivityOccurrence]] = []
    var selectedPetIndex: Int = -1 {
        didSet {
            if(selectedPetIndex != oldValue){
                updateDataAndUI()
            }
        }
    }
    var selectedPet: Pet? {
        guard selectedPetIndex >= 0 && selectedPetIndex < petList.count else { return nil }
        return petList[selectedPetIndex]
    }
    
    lazy var newActivityButton: NewActivityButton = {
        let button = NewActivityButton()
        button.buttonText = "New Activity"
        return button
    }()
    
    lazy var petSelectorCollectionView: UICollectionView = {
        var collectionView: UICollectionView!

        let layout = buildPetSelectorLayout { visibleItems, offset, env in
            guard collectionView != nil else { return }
            let center = self.view.convert(collectionView.center, to: collectionView)

            if let indexPath = collectionView.indexPathForItem(at: center) {
                self.selectedPetIndex = indexPath.row
            }
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PetBadgeComponent.self, forCellWithReuseIdentifier: PetBadgeComponent.reuseIdentifier)
        collectionView.register(AddPetCollectionViewCell.self, forCellWithReuseIdentifier: AddPetCollectionViewCell.reuseIdentifier)
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .Background.primary
        collectionView.dataSource = self

        return collectionView
    }()

    
    
    lazy var taskTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(HealthDailyHeaderView.self, forHeaderFooterViewReuseIdentifier: HealthDailyHeaderView.reuseIdentifier)
        tableView.register(HealthCommitmentTableViewCell.self, forCellReuseIdentifier: HealthCommitmentTableViewCell.reuseIdentifier)
        
        tableView.backgroundColor = .Background.primary
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    lazy var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.template = .noHealthSchedules
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        view.backgroundColor = .Background.primary
        navigationItem.title = "Health"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        newActivityButton.addTarget(self, action: #selector(handleNewActivityButtonTapped), for: .touchUpInside)
    }
    
    @objc private func handleNewActivityButtonTapped() {
        let newActivityController: NewActivityCategoryController = NewActivityCategoryController()
        newActivityController.delegate = self
        newActivityController.selectedPet = selectedPet
        newActivityController.categories = [HealthCategory.medication,HealthCategory.vaccines,  HealthCategory.appointments]
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: newActivityController)
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        present(navigationController, animated: true, completion: nil)
    }
    
    func updateDataAndUI() {
        buildTableData()
        taskTableView.reloadData()
        petSelectorCollectionView.reloadData()
        
        if selectedPet == nil {
            emptyStateView.template = .addNewPet
        } else {
            emptyStateView.template = .noHealthSchedules
        }
        
        emptyStateView.isHidden = !tableRows.isEmpty
        taskTableView.isHidden = tableRows.isEmpty
    }
}

extension HealthViewController: CanReloadView {
    func reloadView() {
        updateDataAndUI()
    }
}
