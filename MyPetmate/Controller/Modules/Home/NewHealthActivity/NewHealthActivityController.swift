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
            print("novo valor, \(category)")
        }
    }
    
    private var durationHeightConstraint: NSLayoutConstraint?
    private var frequencyHeightConstraint: NSLayoutConstraint?
    private var portionHeightConstraint: NSLayoutConstraint?
    var onToggle: ((Bool) -> Void)?
    
    lazy var headerView: HeaderNewActivity = {
        let header = HeaderNewActivity(label: "New Health Activity")
        header.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        header.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var titlePage: UILabel = {
        let label = UILabel()
        label.font = UIFont.title2Emphasized
        label.textColor = .Label.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: text input
    lazy var namedTextField: NamedTextField = {
        let textField = NamedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.name = "Label"
        textField.placeholder = "Antibiotics"
        return textField
    }()
    
    lazy var locationField: NamedTextField = {
        let location = NamedTextField()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.name = "Location"
        location.placeholder = "Enter the address"
        return location
    }()
    
    //MARK: picker generico
    lazy var durationField: PickerActivities = {
        let field = PickerActivities(pickerType: .duration)
        field.onToggle = { [weak self] isExpanded in
            self?.expandDurationField(show: isExpanded)
        }
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var portionField: PickerActivities = {
        let field = PickerActivities(pickerType: .portion)
        field.onToggle = { [weak self] isExpanded in
            self?.expandDurationField(show: isExpanded)
        }
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var frequencyField: FrequencyActivity = {
        let field = FrequencyActivity()
        field.onToggle = { [weak self] isExpanded in
            self?.expandFrequencyField(show: isExpanded)
        }
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
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
        view.addSubview(namedTextField)

        durationField.removeFromSuperview()
        portionField.removeFromSuperview()
        locationField.removeFromSuperview()

        let field = getField(for: category)
        view.addSubview(field)

        view.addSubview(frequencyField)
    }
    
    func setupConstraints() {
        let field = getField(for: category)
        
        durationHeightConstraint = field.heightAnchor.constraint(equalToConstant: 44)
        frequencyHeightConstraint = frequencyField.heightAnchor.constraint(equalToConstant: 44)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            titlePage.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            titlePage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            namedTextField.topAnchor.constraint(equalTo: titlePage.bottomAnchor, constant: 16),
            namedTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            namedTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            field.topAnchor.constraint(equalTo: namedTextField.bottomAnchor),
            field.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            field.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            frequencyField.topAnchor.constraint(equalTo: field.bottomAnchor),
            frequencyField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            frequencyField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            durationHeightConstraint!,
            frequencyHeightConstraint!
        ])
    }
    
    func expandDurationField(show: Bool) {
        durationHeightConstraint?.constant = show ? 148 : 44
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func expandFrequencyField(show: Bool) {
        frequencyHeightConstraint?.constant = show ? 148 : 44
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func getField(for category: String) -> UIView {
        switch category {
        case "Medication", "Activity":
            return durationField
        case "Vaccine", "Appointments":
            return locationField
        case "Feeding", "Water":
            return portionField
        default:
            return durationField
        }
    }
}
