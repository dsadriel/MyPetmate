//
//  LabelDateHour.swift
//  MyPetmate
//
//  Created by Isadora Ferreira Guerra on 14/05/25.
//
import UIKit

class LabelDateHour: UIView {
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Label.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    func configure(isDate: Bool, date: Date?) {
        if isDate == true, let date = date {
            let formatter = DateFormatter()
//            formatter.dateFormat = "dd/MM/yyyy"
            formatter.dateStyle = .long
            informationLabel.text = formatter.string(from: date)
        } else if isDate == false, let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a" //para calendário de 12h
            informationLabel.text = formatter.string(from: date)
        }else {
            fatalError("Neither date nor hour was provided.")
        }
    }

}


extension LabelDateHour: ViewCodeProtocol {
    func setup(){
        self.backgroundColor = .Background.terciary
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 6
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        self.addSubview(informationLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            informationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            informationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.heightAnchor.constraint(equalToConstant: 34),
            self.widthAnchor.constraint(equalTo: informationLabel.widthAnchor, constant: 22)
        ])
    }
    
    
}
