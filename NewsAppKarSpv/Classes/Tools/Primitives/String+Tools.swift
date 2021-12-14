//
//  String+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-15.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func urlFromString() -> URL? {
        if self != "null" {
            return URL(string: self)
        }
        return nil
    }
}
