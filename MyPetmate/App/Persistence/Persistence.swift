//
//  Persistence.swift
//  MyPetmate
//
//  Created by Adriel de Souza on 19/05/25.
//

import Foundation

struct Persistence {
    private static let applicationDataKey = "myPetmateAppData"

    // MARK: Generic aplication data
    static func getApplicaitonData() -> ApplicationData {
        if let data = UserDefaults.standard.value(forKey: applicationDataKey) as? Data {
            do {
                return try ApplicationData.fromData(data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return ApplicationData()
    }

    static func saveApplicaitonData(_ appData: ApplicationData) {
        var appData = appData
        do {
            let encodedData = try appData.toData()
            UserDefaults.standard.set(encodedData, forKey: applicationDataKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    
}
