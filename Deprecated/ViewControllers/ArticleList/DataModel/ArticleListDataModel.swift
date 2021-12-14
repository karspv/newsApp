//
//  ArticleListDataModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-26.
//

import Foundation

class ArticleListDataModel: ArticleListDataModelInterface {

    // MARK: - Declarations
    var source: SourceEntity
    var articleList: [ArticleEntity] = []

    // MARK: - Dependencies
    var articleApiClient: ArticleApiClientInterface = ArticleApiClient()

    // MARK: - Methods
    init(source: SourceEntity) {
        self.source = source
    }

    func loadData(onStart: @escaping() -> Void,
                  onSuccess: @escaping() -> Void,
                  onError: @escaping() -> Void) {

        articleApiClient.loadArticleList(sourceId: source.id, onStart: {
            DispatchQueue.mainSyncSafe {
                onStart()
            }
        }, onSuccess: { [weak self] (articleList) in
            DispatchQueue.mainSyncSafe {
                self?.articleList = articleList
                onSuccess()
            }
        }, onError: {
            DispatchQueue.mainSyncSafe {
                onError()
            }
        })
    }
}
