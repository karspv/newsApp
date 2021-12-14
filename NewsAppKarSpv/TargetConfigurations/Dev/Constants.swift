//
//  Constants.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-03.
//

import Foundation

class Constants {
    
    class APIOperation {
        static let key = "b1d6e05c84d642dd82fd292961149e73"
        static let serverOperationTimeoutInterval: TimeInterval = 30
        static let headerContentType: String = "application/json"
        
        static let serverScheme: String = "https"
        static let serverHost: String = "newsapi.org"
        static let serverCommonPathStart: String = "/v2/"
    }
}
