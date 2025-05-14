//
//  Extensions.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 13/05/25.
//
import UIKit
extension UIView {
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 153 / 255.0, green: 209 / 255.0, blue: 190 / 255.0, alpha: 1).cgColor, // #99D1BE
            UIColor(red: 127 / 255.0, green: 176 / 255.0, blue: 159 / 255.0, alpha: 1).cgColor  // #7FB09F
        ]
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
