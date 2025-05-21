//
//  NewActivityController.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 19/05/25.
//
import UIKit
class NewActivityCategoryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(.Button.primary, for: .normal)
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var newTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "New Activity"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .Label.primary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    var categories: [LabelRepresentable] = []

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 12

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(CategoryAndAnimalCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return collection
    }()


    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .Label.primary
        label.font = .title2Emphasized
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryAndAnimalCell else {
                return UICollectionViewCell()
            }
            
            let item = categories[indexPath.item]
            cell.configure(with: item)
            
            cell.onTap = { [weak self] in
                 self?.handleNewActivityButtonTapped(for: item)
             }
            
            return cell
        }

        // MARK: - UICollectionViewDelegateFlowLayout

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let itemsPerRow: CGFloat = 2
            let spacing: CGFloat = 12
            let totalSpacing = spacing * (itemsPerRow - 1)
            let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
            
            return CGSize(width: width, height: 103)
        }
    
    private func handleNewActivityButtonTapped(for item: LabelRepresentable) {
        let nextVC = NewHealthActivityController()
        nextVC.category = item.title
        nextVC.setup()
        print(item.title)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func cancelButtonTapped() {
            dismiss(animated: true, completion: nil)
    }
}

extension NewActivityCategoryController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
        view.backgroundColor = .Background.primary
    }
    func addSubviews() {
        self.view.addSubview(newTaskLabel)
        self.view.addSubview(cancelButton)
        self.view.addSubview(textLabel)
        self.view.addSubview(collectionView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              
            newTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newTaskLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            newTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            textLabel.topAnchor.constraint(equalTo: newTaskLabel.bottomAnchor, constant: 27),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

