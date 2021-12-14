//
//  Data+Tools.swift
//  NewsAppKarSpv
//
//  Created by Admin on 2021-03-16.
//

import Foundation

extension Data {
    
    func text() -> String {
        return String(decoding: self, as: UTF8.self)
    }
}
