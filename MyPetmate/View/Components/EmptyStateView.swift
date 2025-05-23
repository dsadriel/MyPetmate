//
//  EmptyStateView.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 22/05/25.
//

import UIKit

class EmptyStateView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    enum EmptyStateTemplate {
        case noActivitiesForToday, noHealthSchedules, noActivitiesRegistered
        
        var title: String {
            switch self {
            case .noActivitiesForToday:
                return "No activities for today"
            case .noHealthSchedules:
                return "No health schedules"
            case .noActivitiesRegistered:
                return "Nenhuma atividade registrada."
            }
        }
        
        var subtitle: String {
            return "Add a new activity to view in this pet's list"
        }
        
        var imageSystemName: String {
            switch self {
            case .noActivitiesForToday, .noActivitiesRegistered:
                return "calendar.badge.plus"
            case .noHealthSchedules:
                return "cross.circle.fill"
            }
        }
    }
    
    var template: EmptyStateTemplate = .noActivitiesForToday {
        didSet {
            applyTemplate(template)
        }
    }
    
    private func applyTemplate(_ template: EmptyStateTemplate) {
        title = template.title
        subtitle = template.subtitle
        imageSystemName = template.imageSystemName
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    var imageSystemName: String? {
        didSet {
            if let name = imageSystemName {
                iconImageView.image = UIImage(systemName: name)
            }
        }
    }
    
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title1Emphasized
        label.textColor = .Label.primary
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyRegular
        label.textColor = .Label.primary
        label.textAlignment = .center
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .Label.primary
        imageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // MARK: - Setup
    
    internal func setup() {
        addSubviews()
        setupConstraints()
    }
}

extension EmptyStateView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        [iconImageView, titleLabel, subtitleLabel].forEach {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
    }
}
