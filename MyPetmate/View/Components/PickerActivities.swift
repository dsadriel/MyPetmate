import UIKit

class PickerActivities: UIView {
    
    enum PickerType {
        case portion
        case duration
        case weight
    }
    
    private let numbers = Array(0...99)
    private let units = ["Forever", "Days", "Weeks", "Months", "Years"]
    private let measures = ["mg", "g", "mL", "L"]
    private let weightNumbers = Array(0...9)
    private let weightMeasures = ["Kg", "g"]

    private var selectedNumber = 0
    private var selectedUnit = ""
    private var weightDigits = [0,0,0]
    private var finalNumber = 0

    private let pickerType: PickerType

    var onToggle: ((Bool) -> Void)?
    
    var selectedValue: String {
        switch pickerType {
        case .weight:
            let int = weightDigits[0]
            let dec = weightDigits[1]
            let hun = weightDigits[2]
            return "\(int)\(dec)\(hun) \(selectedUnit)"
        default:
            if selectedUnit == "Forever" {
                        return "Forever"
            } else {
                return "\(selectedNumber) \(selectedUnit)"
            }
        }
    }

    internal lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        return label
    }()

    private lazy var placeHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyRegular
        label.textColor = .Label.primary
        return label
    }()

    private lazy var upDownImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.up.chevron.down"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .Label.secondary
        return imageView
    }()

    private lazy var stackPlaceHolder: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeHolder, upDownImage])
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

    private lazy var pickerView: UIPickerView = {
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
            pickerView
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init(pickerType: PickerType) {
        print("teste")
        self.pickerType = pickerType
        super.init(frame: .zero)
        configureForType()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureForType() {
        switch pickerType {
        case .portion:
            label.text = "Portion"
            placeHolder.text = "50 mL"
            selectedUnit = measures.first ?? ""
        case .duration:
            label.text = "Duration"
            placeHolder.text = "10 min"
            selectedUnit = units.first ?? ""
        case .weight:
            label.text = "Weight"
            placeHolder.text = "5 Kg"
            selectedUnit = weightMeasures.first ?? ""
            
        }
    }

    @objc private func togglePicker() {
        pickerView.isHidden.toggle()
        onToggle?(pickerView.isHidden == false)
    }
}

extension PickerActivities: ViewCodeProtocol {
    func setup() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        addSubviews()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePicker))
        stackPlaceHolder.isUserInteractionEnabled = true
        stackPlaceHolder.addGestureRecognizer(tapGesture)
        
        pickerView.isHidden = true
        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.selectRow(0, inComponent: 1, animated: false)
        
        selectedNumber = numbers[0]
    }

    func addSubviews() {
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
            pickerView.heightAnchor.constraint(equalToConstant: 100),

            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

extension PickerActivities: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerType == .weight ? 4 : 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case .weight:
            // as três primeiras colunas usam weightNumbers, a última usa weightMeasures
            return (component < 3)
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
            if component < 3 {
                return "\(weightNumbers[row])"
            } else {
                return weightMeasures[row]
            }

        case .portion:
            return (component == 0)
                ? "\(numbers[row])"
                : measures[row]

        case .duration:
            return (component == 0)
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
            let integerPart = weightDigits[0]
            let firstDecimal = weightDigits[1]
            let secondDecimal = weightDigits[2]
            let weightString = "\(integerPart)\(firstDecimal)\(secondDecimal)"
            
            finalNumber = Int(weightString) ?? 0
            placeHolder.text = "\(finalNumber) \(selectedUnit)"
            
        case .portion:
            if component == 0 {
                selectedNumber = numbers[row]
            } else {
                selectedUnit = measures[row]
            }
            
            finalNumber = selectedNumber
            placeHolder.text = "\(finalNumber) \(selectedUnit)"

        case .duration:
            if component == 0 {
                selectedNumber = numbers[row]
            } else {
                selectedUnit = units[row]
            }
            
            finalNumber = selectedNumber
            placeHolder.text = "\(finalNumber) \(selectedUnit)"
        }
        
        
    }
}

