//
//  DailyViewController.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

class DailyViewController: UIViewController {
    
    internal var petList: [Pet] = Persistence.getPetList()
    internal var tableSections: [DailyCategory] = []
    internal var tableRows: [[DailyActivityOccurrence]] = []
    internal var selectedPetIndex: Int = -1 {
        didSet {
            if(selectedPetIndex != oldValue){
                print("selectedPetIndex: \(selectedPetIndex)")
                updateDataAndUI()
            }
        }
    }
    internal var selectedPet: Pet? {
        guard selectedPetIndex >= 0 && selectedPetIndex < petList.count else { return nil }
        return petList[selectedPetIndex]
    }

    internal lazy var navigationLeftBarItem: UIBarButtonItem = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE MMMMd")
        
        let formatedDate = dateFormatter.string(from: Date())
        let dataButton = UIBarButtonItem()
        dataButton.title = formatedDate
        dataButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.bodyRegular,
            NSAttributedString.Key.foregroundColor: UIColor.Label.terciary
        ], for: .disabled)
        dataButton.isEnabled = false
        
        return dataButton
    }()
    
    internal lazy var newActivityButton: NewActivityButton = {
        let button = NewActivityButton()
        button.buttonText = "New Activity"
        return button
    }()
    
    internal lazy var petSelectorCollectionView: UICollectionView = {
        // TEMP placeholder to use in layout logic
        var collectionView: UICollectionView!

        let layout = buildPetSelectorLayout { visibleItems, offset, env in
            guard collectionView != nil else { return }
            let center = self.view.convert(collectionView.center, to: collectionView)

            if let indexPath = collectionView.indexPathForItem(at: center) {
//                print("Centered item is at indexPath: \(indexPath)")
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
        collectionView.delegate = self

        return collectionView
    }()

    
    
    internal lazy var taskTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(HealthDailyHeaderView.self, forHeaderFooterViewReuseIdentifier: HealthDailyHeaderView.reuseIdentifier)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseIdentifier)
        
        tableView.backgroundColor = .Background.primary
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        view.backgroundColor = .Background.primary
        navigationItem.title = "Daily"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = navigationLeftBarItem
        
        newActivityButton.addTarget(self, action: #selector(handleNewActivityButtonTapped), for: .touchUpInside)
    }
    
    @objc private func handleNewActivityButtonTapped() {
        let newActivityController: NewActivityCategoryController = NewActivityCategoryController()
        newActivityController.categories = [DailyCategory.activity, DailyCategory.feeding, DailyCategory.water, HealthCategory.medication]
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: newActivityController)
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        present(navigationController, animated: true, completion: nil)
    }
    
    func updateDataAndUI() {
        buildTableData()
        taskTableView.reloadData()
        petSelectorCollectionView.reloadData()
    }
}
