//
//  APIClient.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-08.
//

import Foundation

class APIClient {
    
    static func loadDataFrom(url: URLRequest,
                             onSuccess: @escaping(Data) -> Void,
                             onError: @escaping(Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let task: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("ERROR! Failed to perform request: \(url), error  : \(error)")
                onError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("ERROR!: Failed to get HTTP response: \(url)")
                onError(nil)
                return
            }
            
            guard (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) else {
                print("ERROR! HTTP Response code is \(httpResponse.statusCode), for url: \(url)")
                onError(nil)
                return
            }
            
            guard let data = data else {
                print("ERROR! Returned no data, for url: \(url)")
                onError(nil)
                return
            }
            onSuccess(data)
        }
        task.resume()
    }
}
