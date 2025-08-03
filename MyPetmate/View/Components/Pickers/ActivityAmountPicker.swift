import UIKit

class ActivityAmountPicker: UIView {
    
    // MARK: – Properties
    
    var category: DailyCategory? {
        didSet {
            switch category {
            case .feeding, .water:
                placeHolder.setTitle("Select portion", for: .normal)
                label.text = "Portion"
            case .activity:
                placeHolder.setTitle("Select duration", for: .normal)
                label.text = "Duration"
            case nil:
                return
            }
        }
    }
    
    var selectedValue: Int? {
        guard let selectedAmount = selectedAmount else { return nil }
        var factor = 0

        switch category {
        case .feeding:
            if selectedMeasure == "mg" {
                factor = 1/1000
            } else if selectedMeasure == "g" {
                factor = 1
            } else if selectedMeasure == "kg" {
                factor = 1000
            }
            return Int(Double(selectedAmount) * Double(factor))
        case .water:
            if selectedMeasure == "ml" {
                factor = 1
            } else if selectedMeasure == "L" {
                factor = 1000
            }
        case .activity:
            if selectedMeasure == "minutes" {
                factor = 1
            } else if selectedMeasure == "hours" {
                factor = 60
            }
        case nil:
            return nil
        }
        
        return selectedAmount * factor
    }
    
    private var measures: [String] {
        guard let category = category else { return [] }
        switch category {
        case .activity:
            return ["minutes", "hours"]
        case .feeding:
            return ["mg", "g", "kg"]
        case .water:
            return ["ml", "L"]
        }
    }
    private var selectedMeasure: String?
    
    private var inputRange: [Int] {
        guard let category = category else { return Array(0...1) }
            switch category {
            case .activity:
                var inputRange_ = [1]
                if selectedMeasure == "hours" {
                    inputRange_ = Array(1...24)
                } else {
                    inputRange_.append(contentsOf:Array(stride(from: 5, through: 120, by: 5)))
                }
                return inputRange_
            case .feeding:
                if selectedMeasure == "kg" {
                    return Array(1...10)
                }
                else {
                    var inputRange_ = [1]
                    inputRange_.append(contentsOf: Array(stride(from: 10, through: 1000, by: 10)))
                    return inputRange_
                }
            case .water:
                if selectedMeasure == "ml" {
                    return Array(stride(from: 50, through: 3000, by: 50))
                } else {
                    return Array(1...10)
                }
            }
        
        return Array(0...1)
    }
    
    private var selectedAmount: Int?
    
    
    var onToggle: ((Bool) -> Void)?


    // MARK: – Subviews
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.bodyRegular
        lbl.textColor = .Label.primary
        return lbl
    }()
    
    private lazy var placeHolder: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "?"
        config.indicator = .popup
        let b = UIButton(configuration: config)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tintColor = .Label.secondary
        b.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return b
      }()
    
    private lazy var generalStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [label, placeHolder])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .center
        return sv
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    private lazy var underlineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .Separator.primary
        return v
    }()
    
    private lazy var mainStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            generalStack,
            underlineView,
            pickerView
        ])
        sv.axis = .vertical
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: – Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: – Configuration

    @objc private func togglePicker() {
        pickerView.isHidden.toggle()
        onToggle?(pickerView.isHidden == false)
    }
}

// MARK: – ViewCodeProtocol

extension ActivityAmountPicker: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubviews()
        setupConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(togglePicker))
        placeHolder.isUserInteractionEnabled = true
        placeHolder.addGestureRecognizer(tap)
        
        pickerView.isHidden = true
        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.selectRow(0, inComponent: 1, animated: false)
}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            generalStack.heightAnchor.constraint(equalToConstant: 44),
            underlineView.heightAnchor.constraint(equalToConstant: 0.5),
            pickerView.heightAnchor.constraint(equalToConstant: 100),
            
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

// MARK: – UIPickerViewDataSource & Delegate

extension ActivityAmountPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? inputRange.count : measures.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? String(inputRange[row]) : String(measures[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedAmount = inputRange[row]
            if selectedMeasure == nil {
                selectedMeasure = measures[0]
            }
        } else {
            selectedMeasure = measures[row]
            pickerView.selectRow(0, inComponent: 0, animated: true)
            selectedAmount = inputRange[0]
            pickerView.reloadAllComponents()
            pickerView.reloadInputViews()
        }
        if let selectedAmount = selectedAmount, let selectedMeasure = selectedMeasure {
            placeHolder.setTitle("\(selectedAmount) \(selectedMeasure)", for: .normal)
        }
    }
}
