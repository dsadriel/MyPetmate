//
//  DailySectionHeader.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 13/05/25.
//

import UIKit

/// `HealthDailySectionHeader`
/// A custom header view for displaying a daily section in a table view, used in health tracking.
///
/// - Left side: Shows an icon (e.g., fork.knife) and a title (e.g., section name).
/// - Right side (optional): Shows goal progress (e.g., "100/300 g") and an edit button.
/// - The right side is only visible if `goalTarget` is set (not nil).
class HealthDailySectionHeader: UITableViewHeaderFooterView {
    static var reuseIdentifier = "DailySectionHeader"

    // MARK: - Intializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    // MARK: Left Stack
    private lazy var iconView: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "fork.knife"))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .Icon.primary

        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 22)
        ])

        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return icon
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title2Emphasized
        label.textColor = .Label.primary
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()

    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: Right Stack (Goal Info + Edit Button)
    private lazy var goalProgressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.title2Semibold
        label.textColor = .Button.primary
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var goalTargetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyRegular
        label.textColor = .Button.primary
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var goalInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [goalProgressLabel, goalTargetLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var editGoalButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonImage = UIImage(systemName: "plusminus.circle")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .Button.primary
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        // Connect the action
        button.addTarget(self, action: #selector(editGoalTapped), for: .touchUpInside)

        return button
    }()

    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [goalInfoStackView, editGoalButton])
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: Header Stack (Main container for left + right)
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    // MARK: - Configuration (Public API)

    /// Text displayed as the header's title
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }

    /// Name of the SF Symbol icon to be shown on the left
    var iconImageName: String? {
        didSet {
            iconView.image = UIImage(systemName: iconImageName ?? "")
        }
    }

    /// The current progress value (e.g., "5")
    var goalProgress: String? {
        didSet {
            goalProgressLabel.text = goalProgress
        }
    }

    /// The goal target value (e.g., "10")
    /// - If set to `nil`, the entire rightStackView is hidden
    var goalTarget: String? {
        didSet {
            if let goalTarget {
                goalTargetLabel.text = "/\(goalTarget)"
                rightStackView.isHidden = false
            } else {
                rightStackView.isHidden = true
            }
        }
    }

    /// Closure triggered when the edit button is tapped
    var changeGoalAction: () -> Void = {}

    // MARK: - Actions

    /// Invokes the external goal change action when the edit button is tapped
    @objc private func editGoalTapped() {
        changeGoalAction()
    }
}

// MARK: - ViewCode Setup
extension HealthDailySectionHeader: ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        self.addSubview(headerStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Header fixed height
            self.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
}
