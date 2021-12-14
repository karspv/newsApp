//
//  SourceApiClient.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-03.
//

import Foundation

class SourceApiClient2: SourceApiClientInterface {
    
    // MARK: - Methods
    func loadSourceList(onStart: @escaping() -> Void,
                        onSuccess: @escaping([SourceEntity]) -> Void,
                        onError: @escaping() -> Void) {
        onStart()
        
        guard let url: URL = URLFactory.urlWith(path: "\(Constants.API.version)/sources") else {
            print("ERROR! Could not get sources url")
            onError()
            return
        }
        let request: URLRequest = URLRequestFactory.requestFor(url: url, authorizationKey: Constants.API.key)
        
        APIClient.loadDataFrom(url: request, onSuccess: { (data: Data) in
            guard let dictList: [[String: Any]] = data.dictListFor(key: "sources") else {
                print("ERROR! Could not get DictList from: \(data.text())")
                onError()
                return
            }
                        
            let sourceList: [SourceEntity] = SourceEntity.sourceListFrom(dictList: dictList)
            onSuccess(sourceList)
            
        }, onError: { (_) in
            print("ERROR! Could not perform url session data task for: \(url)")
            onError()
        })
    }
}
