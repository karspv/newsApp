//
//  Constants.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-03.
//

import Foundation

class Constants {
    
    class APIOperation {
        static let key = "testTestKeyForAppStore"
        static let serverOperationTimeoutInterval: TimeInterval = 30
        static let headerContentType: String = "application/json"
        
        static let serverScheme: String = "https"
        static let serverHost: String = "newsapi.org"
        static let serverCommonPathStart: String = "/v1/"
    }
}
