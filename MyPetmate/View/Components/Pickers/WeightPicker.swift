import UIKit

class WeightPicker: UIView {

    private let weightNumbers = Array(0...9)
    private let weightMeasures = ["kg", "g"]
    private var selectedUnit = "kg"
    private var selectedNumber = (hundred: 0, ten: 0, unit: 0)
    
    var selectedWeightInGrams: Int {
        return (selectedNumber.hundred * 100) + (selectedNumber.ten * 10) + selectedNumber.unit * (selectedUnit == "kg" ? 1000 : 1)
    }

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
      config.title = "a"
      config.indicator = .popup
      let b = UIButton(configuration: config)
      b.translatesAutoresizingMaskIntoConstraints = false
      b.tintColor = .Label.secondary
      b.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      return b
    }()

    private lazy var spacer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 16).isActive = true
        v.setContentHuggingPriority(.required, for: .horizontal)
        return v
    }()

    private lazy var generalStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [label, placeHolder, spacer])
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

extension WeightPicker: ViewCodeProtocol {

    func setup() {
        label.text = "Weight"
        placeHolder.setTitle("Select weight", for: .normal)

        addSubviews()
        setupConstraints()

        let tap = UITapGestureRecognizer(target: self, action: #selector(togglePicker))
        placeHolder.isUserInteractionEnabled = true
        placeHolder.addGestureRecognizer(tap)

        pickerView.isHidden = true
        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.selectRow(0, inComponent: 1, animated: false)
        pickerView.selectRow(0, inComponent: 2, animated: false)
        pickerView.selectRow(0, inComponent: 3, animated: false)
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

// MARK: – UIPickerViewDataSource & Delegate

extension WeightPicker: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component < 3 ? weightNumbers.count : weightMeasures.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        component < 3 ? "\(weightNumbers[row])": weightMeasures[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch component {
        case 0:
            selectedNumber.hundred = weightNumbers[row]
        case 1:
            selectedNumber.ten = weightNumbers[row]
        case 2:
            selectedNumber.unit = weightNumbers[row]
        case 3:
            selectedUnit = weightMeasures[row]
        default:
            break
        }

        let weightString =
            "\(selectedNumber.hundred * 100 + selectedNumber.ten * 10 + selectedNumber.unit) \(selectedUnit)"
        placeHolder.setTitle(weightString, for: .normal)
    }
}
