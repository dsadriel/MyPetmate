//
//  CustomDatePicker.swift
//  CustomDatePicker
//
//  Created by Arthur Sobrosa on 26/11/24.
//  Edited by Eduardo Camana on 21/05/25
//

import UIKit

protocol CustomDatePickerDelegate: AnyObject {
    func valueChanged(_ sender: UIDatePicker)
    func editingDidBegin(_ sender: UIDatePicker)
    func editingDidEnd(_ sender: UIDatePicker)
}

/// just to make methods implementation optional
extension CustomDatePickerDelegate {
    func valueChanged(_ sender: UIDatePicker) {}
    func editingDidBegin(_ sender: UIDatePicker) {}
    func editingDidEnd(_ sender: UIDatePicker) {}
}

final class CustomDatePicker: UIView {
    // MARK: - Delegate

    weak var delegate: (any CustomDatePickerDelegate)?

    // MARK: - Properties

    /// Add paddings to content size laterals
    override var intrinsicContentSize: CGSize {
        let labelSize = dateLabel.intrinsicContentSize
        let width = labelSize.width * 1.3
        let height = labelSize.height + 1.3
        return CGSize(width: width, height: height)
    }

    override var backgroundColor: UIColor? {
        didSet {
            guard let backgroundColor else { return }

            if backgroundColor == .clear {
                overlayView.backgroundColor = .systemBackground
                return
            }

            overlayView.backgroundColor = backgroundColor
        }
    }

    var color: UIColor? {
        didSet {
            guard let color else { return }

            dateLabel.textColor = color
        }
    }

    var fontWeight: UIFont.Weight? {
        didSet {
            guard let fontWeight else { return }

            dateLabel.font = .systemFont(ofSize: 20, weight: fontWeight)
        }
    }

    enum DatePickerMode {
        case time
        case date
        case dateAndTime

        var mode: UIDatePicker.Mode {
            switch self {
            case .time:
                .time
            case .date:
                .date
            case .dateAndTime:
                .dateAndTime
            }

        }
    }

    var datePickerMode: DatePickerMode? {
        didSet {
            guard let datePickerMode else { return }

            innerDatePicker.datePickerMode = datePickerMode.mode
            dateLabel.text = getDateString(from: Date())
        }
    }

    var minimumDate: Date? {
        didSet {
            guard let minimumDate else { return }

            innerDatePicker.minimumDate = minimumDate
        }
    }

    var maximumDate: Date? {
        didSet {
            guard let maximumDate else { return }

            innerDatePicker.maximumDate = maximumDate
        }
    }

    // MARK: - UI Properties

    private lazy var innerDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(
            self,
            action: #selector(datePickerDateChanged(_:)),
            for: .valueChanged
        )
        datePicker.addTarget(
            self,
            action: #selector(datePickerEditionBegan(_:)),
            for: .editingDidBegin
        )
        datePicker.addTarget(
            self,
            action: #selector(datePickerEditionEnded(_:)),
            for: .editingDidEnd
        )
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.isUserInteractionEnabled = false
        view.layer.zPosition = 1
        view.translatesAutoresizingMaskIntoConstraints = false
            
        
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = getDateString(from: Date())
        label.layer.zPosition = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    @objc
    private func datePickerDateChanged(_ sender: UIDatePicker) {
        dateLabel.text = getDateString(from: sender.date)
        delegate?.valueChanged(sender)
    }

    @objc
    private func datePickerEditionBegan(_ sender: UIDatePicker) {
        delegate?.editingDidBegin(sender)
    }

    @objc
    private func datePickerEditionEnded(_ sender: UIDatePicker) {
        delegate?.editingDidEnd(sender)
    }

    private func getDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current

        if datePickerMode == .date {
            dateFormatter.setLocalizedDateFormatFromTemplate("d MMM yyyy")
        } else if datePickerMode == .dateAndTime {
            let is24HourFormat =
                DateFormatter.dateFormat(
                    fromTemplate: "j",
                    options: 0,
                    locale: Locale.current
                )?.contains("a") == false
            if is24HourFormat {
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            } else {
                dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            }
        } else {
            let is24HourFormat =
                DateFormatter.dateFormat(
                    fromTemplate: "j",
                    options: 0,
                    locale: Locale.current
                )?.contains("a") == false
            if is24HourFormat {
                dateFormatter.dateFormat = "HH:mm"
            } else {
                //dateFormatter.locale = Locale.init(identifier: "en")
                dateFormatter.dateFormat = "hh:mm a"
            }
        }

        return dateFormatter.string(from: date)
    }
}

// MARK: - UI Setup

extension CustomDatePicker {
    private func setupUI() {
        layer.masksToBounds = true

        addSubview(overlayView)
        overlayView.addSubview(dateLabel)
        addSubview(innerDatePicker)
        
        NSLayoutConstraint.activate([
            
            dateLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),

            innerDatePicker.topAnchor.constraint(equalTo: topAnchor),
            innerDatePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            innerDatePicker.bottomAnchor.constraint(equalTo: bottomAnchor),

            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
}
