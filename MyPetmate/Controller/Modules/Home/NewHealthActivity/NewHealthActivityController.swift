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
    
    private var activeDatePicker: DatePicker?
    private var durationHeightConstraint: NSLayoutConstraint?
    private var frequencyHeightConstraint: NSLayoutConstraint?
    private var portionHeightConstraint: NSLayoutConstraint?
    private var activeDatePickers: [DatePicker] = []
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
    lazy var durationActivityField: PickerActivities = {
        let field = PickerActivities(pickerType: .duration)
        field.measures = ["minutes", "hours"]
        field.onToggle = { [weak self] isExpanded in
            self?.expandDurationField(show: isExpanded)
        }
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var durationMedicationField: PickerActivities = {
        let field = PickerActivities(pickerType: .duration)
        field.measures = ["forever", "day(s)", "week(s)", "month(s)", "year(s)"]
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
            
            if !isExpanded {
                self?.updateActiveDatePicker()
            }
        }
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //MARK: date and date-time options
    lazy var DatePickerView: DatePicker = {
        let datePicker = DatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.text = "Time"
        datePicker.hasHour = false
        return datePicker
    }()
    lazy var DateAndTimePickerView: DatePicker = {
        let datePicker = DatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.text = "Date and Time"
        datePicker.hasHour = true
        return datePicker
    }()
    
    lazy var notesTextField: NamedTextField = {
        let textField = NamedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.name = "Notes"
        textField.placeholder = "Extra information"
        return textField
    }()
    
    lazy var pickerList: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .vertical
        return stack
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
    
    func updateActiveDatePicker() {
        activeDatePickers.forEach { $0.removeFromSuperview() }
        activeDatePickers = []

        let selectedFrequency = frequencyField.selectedValue.lowercased()
        print("Selected Frequency:", selectedFrequency)

        guard !selectedFrequency.isEmpty else { return }

        var numberOfPickers = 0

        if selectedFrequency.hasPrefix("once") {
            numberOfPickers = 1
        } else if selectedFrequency.hasPrefix("twice") {
            numberOfPickers = 2
        } else if selectedFrequency.contains("3") {
            numberOfPickers = 3
        } else if selectedFrequency.contains("4") {
            numberOfPickers = 4
        } else if selectedFrequency.contains("5") {
            numberOfPickers = 5
        } else if selectedFrequency.contains("6") {
            numberOfPickers = 6
        }

        guard numberOfPickers > 0 else { return }

        for aux in 0..<numberOfPickers {
            if aux == 1 {
                let datePicker = DatePicker()
                datePicker.text = "Time"
                datePicker.hasHour = false
                datePicker.heightAnchor.constraint(equalToConstant: 44).isActive = true
                
            } else {
                let picker = DatePicker()
                picker.text = "Date and Time"
                picker.hasHour = true
                
                picker.heightAnchor.constraint(equalToConstant: 44).isActive = true
                
                pickerList.addArrangedSubview(picker)
                
                activeDatePickers.append(picker)
                
                
            }
        }
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
        view.addSubview(pickerList)

        durationActivityField.removeFromSuperview()
        durationMedicationField.removeFromSuperview()
        portionField.removeFromSuperview()
        locationField.removeFromSuperview()
        DatePickerView.removeFromSuperview()
        DateAndTimePickerView.removeFromSuperview()

        let field = getField(for: category)
        view.addSubview(field)
        view.addSubview(frequencyField)
        view.addSubview(notesTextField)

    }
    
    func setupConstraints() {
        let field = getField(for: category)

        let constraints: [NSLayoutConstraint] = [
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
            
            pickerList.topAnchor.constraint(equalTo: frequencyField.bottomAnchor, constant: 0),
            pickerList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pickerList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            notesTextField.topAnchor.constraint(equalTo: pickerList.bottomAnchor, constant: 54),
            notesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
    
            
        ]
        
        NSLayoutConstraint.activate(constraints)
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
        case "Medication":
            return durationMedicationField
        case "Activity":
            return durationActivityField
        case "Vaccine", "Appointments":
            return locationField
        case "Feeding", "Water":
            return portionField
        default:
            return durationActivityField
        }
    }
}
