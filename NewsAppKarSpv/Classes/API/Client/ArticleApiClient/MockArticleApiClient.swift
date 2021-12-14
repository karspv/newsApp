//
//  MockArticleApiClient.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-13.
//

import Foundation
@testable import NewsAppKarSpv

// swiftlint:disable identifier_name
class MockArticleApiClient: ArticleApiClientInterface {

    // Should we keep this?
    var loadArticleList_callCount = 0
    var loadArticleList_onSuccess_callback: (([ArticleEntity]) -> Void)?
    var loadArticleList_onError_callback: (() -> Void)?
    
    func loadArticleList(source: SourceEntity,
                         onSuccess: @escaping([ArticleEntity]) -> Void,
                         onError: @escaping() -> Void) {
        loadArticleList_callCount += 1
        loadArticleList_onSuccess_callback = onSuccess
        loadArticleList_onError_callback = onError
    }
    
    func setArticleFavouriteState(article: ArticleEntity,
                                  favouriteStateTo isFavoruite: Bool,
                                  onSuccess: @escaping (Bool) -> Void,
                                  onError: @escaping () -> Void) {
    }
}
