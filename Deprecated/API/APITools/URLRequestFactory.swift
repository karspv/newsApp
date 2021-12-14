//
//  URLRequestFactory.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-16.
//

import Foundation

class URLRequestFactory {
    
    static func requestFor(url: URL, authorizationKey: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorizationKey, forHTTPHeaderField: "Authorization")
        return request
    }
}
