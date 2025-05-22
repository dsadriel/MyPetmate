//
//  SelectableEnum.swift
//  MyPetmate
//
//  Created by Gabriel Barbosa on 20/05/25.
//

import Foundation

protocol SelectableEnum: CaseIterable & RawRepresentable where RawValue == String {
    
    var displayName: String { get }
    
}

extension SelectableEnum {
    var displayName: String {
        return rawValue.capitalizingFirstLetter()
    }
}
