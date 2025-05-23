//
//  FrequencyActivity.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 20/05/25.
//

import UIKit
class FrequencyActivity: UIView {
    private let frequency = ["Once", "Twice", "3 times", "4 times", "5 times", "6 times"]
    private let units = ["a day", "a week", "a month", "a year"]
    
    private var selectedFrequency = ""
    private var selectedUnit = ""
    
    var onToggle: ((Bool) -> Void)?
    
    var selectedValue: String {
        if selectedUnit == "Forever" {
            return "Forever"
        } else {
            return "\(selectedFrequency) \(selectedUnit)"
        }
    }
    
    var selectedInterval: ActivityInterval {
        switch selectedUnit {
        case "a day":
            return  ActivityInterval.daily
        case "a week":
            return ActivityInterval.weekly
        case "a month":
            return ActivityInterval.monthly
        case "a year":
            return ActivityInterval.yearly
        default:
            return ActivityInterval.daily
        }
    }

    internal lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Frequency"
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        return label
    }()
    
    private lazy var placeHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Twice a month"
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        return label
    }()
    
    private lazy var UpDownImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.up.chevron.down"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .Label.secondary
        return imageView
    }()
    
    private lazy var stackPlaceHolder: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeHolder, UpDownImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 9
        return stackView
    }()
    
    private lazy var generalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, stackPlaceHolder])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var durationPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Separator.primary
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            generalStack,
            underlineView,
            durationPickerView
        ])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func togglePicker() {
        durationPickerView.isHidden.toggle()
        onToggle?(durationPickerView.isHidden == false)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedFrequency = frequency[row]
        } else {
            selectedUnit = units[row]
        }

        let text: String
        if selectedUnit == "Forever" {
            text = "Forever"
        } else {
            text = "\(selectedFrequency) \(selectedUnit)"
        }

        placeHolder.text = text
        placeHolder.textColor = .Label.primary
    }

}

extension FrequencyActivity: ViewCodeProtocol {
    func setup() {
        self.layer.masksToBounds = true
        
        addSubviews()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePicker))
        stackPlaceHolder.isUserInteractionEnabled = true
        stackPlaceHolder.addGestureRecognizer(tapGesture)
        
        durationPickerView.isHidden = true
        
        durationPickerView.selectRow(0, inComponent: 0, animated: false)
        durationPickerView.selectRow(0, inComponent: 1, animated: false)
        selectedFrequency = frequency[0]
        selectedUnit = units[0]
        
        placeHolder.text = "Select frequency"
        placeHolder.textColor = .Unselected.primary


    }

    func addSubviews() {
        addSubview(stackPlaceHolder)
        addSubview(underlineView)
        addSubview(generalStack)
        addSubview(durationPickerView)
        addSubview(mainStack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),

            generalStack.heightAnchor.constraint(equalToConstant: 44),
            underlineView.heightAnchor.constraint(equalToConstant: 0.5),
            durationPickerView.heightAnchor.constraint(equalToConstant: 100),
            
            underlineView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
        ])

    }

}


extension FrequencyActivity: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? frequency.count : units.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? frequency[row] : units[row]
    }

}
