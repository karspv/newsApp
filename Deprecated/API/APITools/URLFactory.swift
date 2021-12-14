//
//  URLFactory.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-10.
//

import Foundation

class URLFactory {
    
    static func urlWith(path: String, queryItemList: [URLQueryItem] = []) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.API.urlScheme
        urlComponents.host = Constants.API.urlHost
        urlComponents.path = path
        if !queryItemList.isEmpty {
            urlComponents.queryItems = queryItemList
        }
        return urlComponents.url
    }
}
