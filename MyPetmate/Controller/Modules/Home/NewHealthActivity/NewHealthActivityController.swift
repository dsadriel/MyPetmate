//
//  NewHealthActivityController.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 20/05/25.
//
import UIKit
class NewHealthActivityController: UIViewController {

    var category: String = "" {
        didSet {
            titlePage.text = category
        }
    }
    
    lazy var headerView: HeaderNewActivity = {
        let header = HeaderNewActivity(label: "New Health Activity")
        header.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        header.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var titlePage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .Label.primary
        label.font = UIFont.title2Emphasized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .Label.primary
        label.font = UIFont.title2Emphasized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancelButtonTapped() {
            dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        print("botao de salvar clicado")
    }
}

extension NewHealthActivityController: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
        view.backgroundColor = .Background.primary
        titlePage.text = category
    }
    func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(titlePage)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            titlePage.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            titlePage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            titlePage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

