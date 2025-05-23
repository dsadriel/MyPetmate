import UIKit

class PickerActivities: UIView {
    
    enum PickerType {
        case portion
        case duration
        case weight
    }
    
    // MARK: – Properties
    
    private let pickerType: PickerType
    private let numbers = Array(0...99)
    private let units = ["Forever", "Days", "Weeks", "Months", "Years"]
    var measures = ["mg", "g", "mL", "L"]
    private let weightNumbers = Array(0...9)
    private let weightMeasures = ["Kg", "g"]
    
    public private(set) var selectedNumber = 0
    public private(set) var selectedUnit = ""
    private var weightDigits = [0, 0, 0]
    private var finalNumber = 0
    
    var onToggle: ((Bool) -> Void)?
    
    public var totalDuration: Int {
            selectedNumber * (selectedUnit == "hours" ? 60 : 1)
    }
    
    public var selectedValue: String {
        switch pickerType {
        case .weight:
            // cria string de três dígitos + unidade
            let intPart = weightDigits[0]
            let decPart = weightDigits[1]
            let hunPart = weightDigits[2]
            return "\(intPart)\(decPart)\(hunPart) \(selectedUnit)"
        default:
            return selectedUnit == "Forever"
                ? "Forever"
                : "\(selectedNumber) \(selectedUnit)"
        }
    }
    
    // MARK: – Subviews
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.bodyRegular
        lbl.textColor = .Label.primary
        return lbl
    }()
    
    private lazy var placeHolder: UILabel = {
        let ph = UILabel()
        ph.translatesAutoresizingMaskIntoConstraints = false
        ph.font = UIFont.bodyRegular
        ph.textColor = .Label.primary
        return ph
    }()
    
    private lazy var upDownImage: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.up.chevron.down"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .Label.secondary
        return iv
    }()
    
    private lazy var stackPlaceHolder: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [placeHolder, upDownImage])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.spacing = 9
        return sv
    }()
    
    private lazy var generalStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [label, stackPlaceHolder])
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
    
    init(pickerType: PickerType) {
        self.pickerType = pickerType
        super.init(frame: .zero)
        configureForType()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: – Configuration
    
    private func configureForType() {
        switch pickerType {
        case .portion:
            label.text = "Portion"
            placeHolder.text = "Select portion"
            selectedUnit = measures.first ?? ""
            
        case .duration:
            label.text = "Duration"
            placeHolder.text = "Select duration"
            selectedUnit = units.first ?? ""
            
        case .weight:
            label.text = "Weight"
            placeHolder.text = "Select weight"
            selectedUnit = weightMeasures.first ?? ""
        }
        placeHolder.textColor = .Unselected.primary
    }

    @objc private func togglePicker() {
        pickerView.isHidden.toggle()
        onToggle?(pickerView.isHidden == false)
    }
}

// MARK: – ViewCodeProtocol

extension PickerActivities: ViewCodeProtocol {
    func addSubviews() {
        addSubview(mainStack)
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubviews()
        setupConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(togglePicker))
        stackPlaceHolder.isUserInteractionEnabled = true
        stackPlaceHolder.addGestureRecognizer(tap)
        
        pickerView.isHidden = true
        // seleciona valores iniciais
        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.selectRow(0, inComponent: 1, animated: false)
        if pickerType == .weight {
            pickerView.selectRow(0, inComponent: 2, animated: false)
            pickerView.selectRow(0, inComponent: 3, animated: false)
        }
        
        selectedNumber = numbers[0]
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

extension PickerActivities: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerType == .weight ? 4 : 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case .weight:
            // primeiros 3 para dígitos, último para unidade
            return component < 3
                ? weightNumbers.count
                : weightMeasures.count
            
        case .portion:
            return component == 0
                ? numbers.count
                : measures.count
            
        case .duration:
            return component == 0
                ? numbers.count
                : units.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerType {
        case .weight:
            return component < 3
                ? "\(weightNumbers[row])"
                : weightMeasures[row]
            
        case .portion:
            return component == 0
                ? "\(numbers[row])"
                : measures[row]
            
        case .duration:
            return component == 0
                ? "\(numbers[row])"
                : units[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerType {
        case .weight:
            if component < 3 {
                weightDigits[component] = weightNumbers[row]
            } else {
                selectedUnit = weightMeasures[row]
            }
            // concatena três dígitos e atualiza placeholder
            let weightString = "\(weightDigits[0])\(weightDigits[1])\(weightDigits[2])"
            finalNumber = Int(weightString) ?? 0
            placeHolder.text = "\(finalNumber) \(selectedUnit)"
            
        case .portion:
            if component == 0 {
                selectedNumber = numbers[row]
            } else {
                selectedUnit = measures[row]
            }
            placeHolder.text = "\(selectedNumber) \(selectedUnit)"
            
        case .duration:
            if component == 0 {
                selectedNumber = numbers[row]
            } else {
                selectedUnit = units[row]
            }
            placeHolder.text = selectedUnit == "Forever"
                ? "Forever"
                : "\(selectedNumber) \(selectedUnit)"
        }
        
        placeHolder.textColor = .Label.primary
    }
}
