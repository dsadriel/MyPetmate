//
//  DailyViewController.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 15/05/25.
//

import UIKit

class DailyViewController: UIViewController {
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: buildPetSelectorLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(PetBadgeComponent.self, forCellWithReuseIdentifier: PetBadgeComponent.reuseIdentifier)
        
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

}
