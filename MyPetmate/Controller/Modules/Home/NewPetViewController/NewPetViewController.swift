//
//  NewPetViewController.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 19/05/25.
//

import UIKit

class NewPetViewController: UIViewController {
    
    private let petCategory: PetType
    var delegate: CanReloadView?

    init(petCategory: PetType) {
        self.petCategory = petCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var header: HeaderNewActivity = {
        var header = HeaderNewActivity(label: "New Pet")
        header.translatesAutoresizingMaskIntoConstraints = false
        header.saveButton.addTarget(self,
                                    action: #selector(savePetTapped),
                                    for: .touchUpInside)
        header.cancelButton.addTarget(self,
                                      action: #selector(cancelTapped),
                                      for: .touchUpInside)
        return header
    }()
    
    internal lazy var imageButton: UIButton = {
        let button = UIButton()
        let baseConfig = UIImage.SymbolConfiguration(pointSize: 80, weight: .bold)
        let paletteConfig = UIImage.SymbolConfiguration(paletteColors: [.Button.primary, .Button.secondary])
        let symbolConfig = baseConfig.applying(paletteConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        button.setImage(UIImage(systemName: "photo.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleImageButton), for: .touchUpInside)

        return button
    }()
    
    lazy var textField: NamedTextField = {
        var textField = NamedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.name = "Name"
        textField.placeholder = "First name or nickname"
        
        return textField
    }()
    
    lazy var sexSelector: EnumSelector<PetSex> = {
        let selector = EnumSelector<PetSex>(
            enumTypeName: "Sex",          // texto do label
            placeholder: "Select Sex"     // texto inicial do botão
        )
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
    
    lazy var breedTextField: NamedTextField = {
        var breed = NamedTextField()
        breed.translatesAutoresizingMaskIntoConstraints = false
        breed.name = "Breed"
        breed.placeholder = "Name of the dog breed"
        
        return breed
    }()
    
    lazy var sizeSelector: EnumSelector<PetSize> = {
        let selector = EnumSelector<PetSize>(
            enumTypeName: "Size",
            placeholder: "Select Size"
        )
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    lazy var wheelPicker: PickerActivities = {
        let picker = PickerActivities(pickerType: .weight)
        
        return picker
    }()
    
    lazy var catBloodTypeSelector: EnumSelector<CatBloodType> = {
        let selector = EnumSelector<CatBloodType>(
            enumTypeName: "Blood Type",
            placeholder: "Select Blood Type"
        )
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    lazy var dogBloodTypeSelector: EnumSelector<DogBloodType> = {
        let selector = EnumSelector<DogBloodType>(
            enumTypeName: "Blood Type",
            placeholder: "Select Blood Type"
        )
        return selector
    }()
    
    lazy var allergiesTextField: NamedTextField = {
        var allergies = NamedTextField()
        allergies.translatesAutoresizingMaskIntoConstraints = false
        allergies.name = "Allergies"
        allergies.placeholder = "None"
        
        return allergies
    }()
    
    lazy var dataStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [textField, sexSelector, datePicker, breedTextField, sizeSelector, wheelPicker,
                                                       petCategory == .dog ? dogBloodTypeSelector : catBloodTypeSelector,
                                                       allergiesTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
//    lazy var mainStackView: UIStackView = {
//        var stackView = UIStackView(arrangedSubviews: [imageButton, dataStackView])
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.spacing = 24
//        return stackView
//    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background.primary
        setup()
        
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func savePetTapped() {
        // como `datePicker.date` não é opcional, basta ler direto
        let selectedDate = datePicker.datePicker.date

        if petCategory == .cat {
            let cat = Cat(
                name:      textField.text ?? "",
                sex:       sexSelector.selectedValue ?? .unknown,
                birthDate: selectedDate,
                breed:     breedTextField.text ?? "",
                size:      sizeSelector.selectedValue ?? .medium,
                weight:    100,
                allergies: allergiesTextField.text ?? ""
            )
            Persistence.addPet(cat)
            if let image = imageButton.imageView?.image {
                Persistence.savePetProfilePicture(image, for: cat)
            }
        } else {
            let dog = Dog(
                name:      textField.text ?? "",
                sex:       sexSelector.selectedValue ?? .unknown,
                birthDate: selectedDate,
                breed:     breedTextField.text ?? "",
                size:      sizeSelector.selectedValue ?? .medium,
                weight:    100,
                allergies: allergiesTextField.text ?? ""
            )
            Persistence.addPet(dog)
            if let image = imageButton.imageView?.image {
                Persistence.savePetProfilePicture(image, for: dog)
            }
        }
        
        delegate?.reloadView()
        self.dismiss(animated: true)
    }

    @objc func handleImageButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageButton.layer.cornerRadius = imageButton.frame.size.width / 2
        imageButton.clipsToBounds = true
        imageButton.imageView?.contentMode = .scaleAspectFill
    }

}

extension NewPetViewController: ViewCodeProtocol {
    func setupConstraints() {
        NSLayoutConstraint.activate([

            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 55),
            
            imageButton.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 24),
            imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageButton.heightAnchor.constraint(equalToConstant: 100),
            imageButton.widthAnchor.constraint(equalToConstant: 100),
            
            
            dataStackView.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 24),
            
            dataStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dataStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
        ])
    }
    
    func addSubviews() {
        view.addSubview(header)
        view.addSubview(imageButton)
        view.addSubview(dataStackView)
    }
    
}

extension NewPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            imageButton.setImage(image, for: .normal)
        }
    }
}
