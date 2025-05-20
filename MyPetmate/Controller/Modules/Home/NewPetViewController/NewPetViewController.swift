//
//  NewPetViewController.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

import UIKit

class NewPetViewController: UIViewController {
    
    internal lazy var imageButton: UIButton = {
        let button = UIButton()
        let baseConfig = UIImage.SymbolConfiguration(pointSize: 80, weight: .bold)
        let paletteConfig = UIImage.SymbolConfiguration(paletteColors: [.Button.primary, .Button.secondary])
        let symbolConfig = baseConfig.applying(paletteConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        button.setImage(UIImage(systemName: "photo.artframe.circle.fill"), for: .normal)
        
        
//        button.addTarget(self, action: #selector(handleImageButton), for: .touchUpInside)
        return button
    }()
    
    lazy var textField: NamedTextField = {
        var textField = NamedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.name = "Name"
        textField.placeholder = "First name or nickname"
        
        return textField
    }()
    
    lazy var sexSelector: SexSelector = {
        var selector = SexSelector()
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    lazy var datePicker: DatePicker = {
        var picker = DatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.text = "Date"
        picker.hasHour = false
        return picker
    }()
    
    lazy var dataStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [textField, sexSelector, datePicker])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [imageButton, dataStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background.primary
        setup()
        
    }
}

extension NewPetViewController: ViewCodeProtocol {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            sexSelector.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sexSelector.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            
            
        ])
    }
    
    func addSubviews() {
        view.addSubview(mainStackView)
    }
    
}
