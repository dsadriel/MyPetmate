//
//  Extensions.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 13/05/25.
//
import UIKit

// MARK: - UIView.addGradient
extension UIView {
    func addGradient() {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        if traitCollection.userInterfaceStyle == .light {
            gradientLayer.colors = [
                UIColor(red: 153 / 255.0, green: 209 / 255.0, blue: 190 / 255.0, alpha: 1).cgColor, // #99D1BE
                UIColor(red: 127 / 255.0, green: 176 / 255.0, blue: 159 / 255.0, alpha: 1).cgColor  // #7FB09F
            ]
            
        } else if traitCollection.userInterfaceStyle == .dark {
            
            gradientLayer.colors = [
            UIColor(red: 253 / 255.0, green: 246 / 255.0, blue: 236 / 255.0, alpha: 1).cgColor,  // #FDF6EC
            UIColor(red: 237 / 255.0, green: 219 / 255.0, blue: 192 / 255.0, alpha: 1).cgColor  // #EDDBC0
            ]
            
        }
               
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Type alias for NSCollectionLayout

typealias Size = NSCollectionLayoutSize
typealias Item = NSCollectionLayoutItem
typealias Group = NSCollectionLayoutGroup
typealias Section = NSCollectionLayoutSection
typealias Layout = UICollectionViewCompositionalLayout
typealias Edges = NSDirectionalEdgeInsets
typealias Config = UICollectionViewCompositionalLayoutConfiguration


// MARK: - End Of Day

extension Date {
    var endOfDay: Date {
        Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
}
