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
            NSAttributedString.Key.foregroundColor: UIColor.Label.secondary
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
    
    lazy var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.template = .noActivitiesForToday
        return view
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
        let modalVC = NewActivityController()
        modalVC.categories = [DailyCategory.activity, DailyCategory.feeding, DailyCategory.water]
        modalVC.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        present(modalVC, animated: true, completion: nil)
    }
    
    func updateDataAndUI() {
        buildTableData()
        taskTableView.reloadData()
        petSelectorCollectionView.reloadData()
        
        
        emptyStateView.isHidden = !tableRows.isEmpty || selectedPet == nil
        taskTableView.isHidden = tableRows.isEmpty
    }
}
