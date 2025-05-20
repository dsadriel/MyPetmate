//
//  ApplicationData.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import Foundation

struct ApplicationData: Codable {
    var registeredPets: [Pet]

    init() {
        registeredPets = []
    }

    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }

    static func fromData(_ data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}
