//
//  ArticleApiClient.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-05.
//

import Foundation

class ArticleApiClient1: ArticleApiClientInterface {
    
    // MARK: - Methods
    func loadArticleList(sourceId: String,
                         onSuccess: @escaping([ArticleEntity]) -> Void,
                         onError: @escaping() -> Void) {
        
        let sourcesQueryItem = URLQueryItem(name: "sources", value: sourceId)
        guard let url: URL = URLFactory.urlWith(path: "\(Constants.API.version)/everything", queryItemList: [sourcesQueryItem]) else {
            print("ERROR! Could not get articles url")
            onError()
            return
        }
        let request = URLRequestFactory.requestFor(url: url, authorizationKey: Constants.API.key)
        
        APIClient.loadDataFrom(url: request, onSuccess: { (data: Data) in
            guard let dictList: [[String: Any]] = data.dictListFor(key: "articles") else {
                print("ERROR! Could not get DictList from: \(data.text())")
                onError()
                return
            }
            
            let articleList: [ArticleEntity] = ArticleEntity.articleListFrom(dictList: dictList)
            onSuccess(articleList)
            
        }, onError: { (_) in
            print("ERROR! Could not perform url session data task for: \(url)")
            onError()
        })
    }
}
