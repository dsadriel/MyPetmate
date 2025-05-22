import UIKit

class PickerActivities: UIView {
    
    enum PickerType {
        case portion
        case duration
    }
    
    private let numbers = Array(0...99)
    public var measures: [String] = [""] {
        didSet {
            configureForType()
        }
    }

    private var selectedNumber = 0
    private var selectedUnit = ""

    private let pickerType: PickerType

    var onToggle: ((Bool) -> Void)?
    
    var selectedValue: String {
        if selectedUnit == "Forever" {
            return "Forever"
        } else {
            return "\(selectedNumber) \(selectedUnit)"
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
        stackView.alignment = .fill
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
        stackView.spacing = 2
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
            placeHolder.text = "Select portion"
        case .duration:
            label.text = "Duration"
            placeHolder.text = "Select duration"
        }
        placeHolder.textColor = .Unselected.primary
        selectedUnit = measures.first ?? ""
    }


    @objc private func togglePicker() {
        pickerView.isHidden.toggle()
        onToggle?(pickerView.isHidden == false)
    }
}

extension PickerActivities: ViewCodeProtocol {
    func setup() {
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

extension PickerActivities: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numbers.count
        } else {
            return measures.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(numbers[row])"
        } else {
            return measures[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedNumber = numbers[row]
        } else {
            selectedUnit = measures[row]
        }
        placeHolder.text = selectedValue
        placeHolder.textColor = .Label.primary

    }
}
