//
//  UserDefaults+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-16.
//

import Foundation

extension UserDefaults {

    func setCodable<T: Codable>(object: T, forKey: String) throws {
        let jsonData: Data = try JSONEncoder().encode(object)
        set(jsonData, forKey: forKey)
    }

    func getCodable<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
}
