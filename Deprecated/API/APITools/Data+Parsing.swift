//
//  DataParser.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-09.
//

import Foundation

extension Data {
    
    func dictListFor(key: String) -> [[String: Any]]? {
        
        var parsedDict: [String: Any]?
        do {
            parsedDict = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            print("ERROR! \(error) Failed to parse json \(String(decoding: self, as: UTF8.self))")
            return nil
        }
        
        return parsedDict?[key] as? [[String: Any]]
    }
}
