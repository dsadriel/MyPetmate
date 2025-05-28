import UIKit

class HeatlhActivityDurationPicker: UIView {

    // MARK: – Properties

    var timeIntervals: [String] = ["Forever", "days", "weeks", "months", "years"]

    var selectedInterval: String?

    var inputRange: [Int] {
        switch selectedInterval {
        case "Forever":
            return []
        case "days":
            return Array(1...60)
        case "weeks":
            return Array(1...52)
        case "months":
            return Array(1...36)
        case "years":
            return Array(1...100)
        default:
            return []
        }
    }

    var selectedAmount: Int?

    var selectedTimeInterval: Date {
        var component: Calendar.Component? {
            switch selectedInterval {
            case "Forever":
                return nil
            case "days":
                return .day
            case "weeks":
                return .weekOfMonth
            case "months":
                return .month
            case "years":
                return .year
            default:
                return nil
            }
        }

        if component != nil {
            return Calendar.current.date(byAdding: component!, value: selectedAmount ?? 0, to: Date())!
        } else {
            return Date.distantFuture
        }

    }

    var onToggle: ((Bool) -> Void)?

    // MARK: – Subviews

    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Duration"
        lbl.font = UIFont.bodyRegular
        lbl.textColor = .Label.primary
        return lbl
    }()

    private lazy var placeHolder: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Select duration"
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
            pickerView,
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

extension HeatlhActivityDurationPicker: ViewCodeProtocol {
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

extension HeatlhActivityDurationPicker: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? inputRange.count : timeIntervals.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? String(inputRange[row]) : String(timeIntervals[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedAmount = inputRange.count > 0 ? inputRange[0] : nil
            
            if selectedInterval == nil {
                selectedInterval = timeIntervals[0]
            }
            
        } else {
            selectedInterval = timeIntervals[row]

            pickerView.selectRow(0, inComponent: 0, animated: true)
            selectedAmount = inputRange.count > 0 ? inputRange[0] : nil

            pickerView.reloadAllComponents()
            pickerView.reloadInputViews()
        }
        
        if let selectedAmount, let selectedInterval {
            placeHolder.setTitle("\(selectedAmount) \(selectedInterval)", for: .normal)
        } else if selectedInterval == "Forever" {
            placeHolder.setTitle("Forever", for: .normal)
        }
    }
}
