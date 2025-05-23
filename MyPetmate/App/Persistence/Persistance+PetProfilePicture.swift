//
//  Persistance+PetProfilePicture.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 23/05/25.
//


import UIKit

extension Persistence {

    static func savePetProfilePicture(_ image: UIImage, for pet: Pet) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let filename = "\(pet.id)ProfilePicture"
        UserDefaults.standard.set(data, forKey: filename)
    }

    static func getPetProfilePicture(for pet: Pet) -> UIImage? {
        let filename = "\(pet.id)ProfilePicture"
        if let data = UserDefaults.standard.data(forKey: filename) {
            return UIImage(data: data)
        }
        return nil
    }
}
