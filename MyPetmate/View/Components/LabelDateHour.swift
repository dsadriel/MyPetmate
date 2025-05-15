//
//  LabelDateHour.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 14/05/25.
//
import UIKit

class LabelDateHour: UIView {
    
    lazy var background: UIView = {
        let background = UIView()
        background.backgroundColor = .Background.terciary
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.cornerRadius = 6
        return background
    }()
    
    lazy var hourView: UILabel = {
        let label = UILabel()
        label.textColor = .Label.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateView: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .Label.primary
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    
    init(isDate: Bool, date: Date?) {
        super.init(frame: .zero)
        
        let toUse: UILabel
        
        if isDate == true, let date = date {
            let formatter = DateFormatter()
//            formatter.dateFormat = "dd/MM/yyyy"
            formatter.dateStyle = .long
            dateView.text = formatter.string(from: date)
            hourView.isHidden = true
            toUse = dateView
        } else if isDate == false, let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a" //para calendário de 12h
            hourView.text = formatter.string(from: date)
            toUse = hourView
        }else {
            fatalError("Neither date nor hour was provided.")
        }
        
        addSubview(background)
        background.addSubview(toUse)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            toUse.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            toUse.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            
            self.widthAnchor.constraint(equalToConstant: 123),
            self.heightAnchor.constraint(equalToConstant: 34)

        ])
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
