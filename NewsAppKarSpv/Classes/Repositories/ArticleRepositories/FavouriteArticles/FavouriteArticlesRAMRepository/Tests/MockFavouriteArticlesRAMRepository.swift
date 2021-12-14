//
//  MockFavouriteArticlesRepository.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-12.
//

import Foundation
@testable import NewsAppKarSpv

// swiftlint:disable identifier_name
class MockFavouriteArticlesRAMRepository: ArticlesRepositoryInterface {
  
    // MARK: - Declarations
    var mockFavouriteArticleList: [ArticleEntity] = []
    
    static var mockShared = MockFavouriteArticlesRAMRepository()
    
    var addArticleToFavourites_article: ArticleEntity?
    var addArticleToFavourites_callCount = 0
    var removeArticleFromFavourites_callCount = 0
    var articleList_callCount = 0
    
    // MARK: - Methods
    func articleList() -> [ArticleEntity] {
        articleList_callCount += 1
        return mockFavouriteArticleList
    }
    
    func add(article: ArticleEntity) {
        addArticleToFavourites_callCount += 1
        addArticleToFavourites_article = article
    }
    
    func removeAllArticlesMatching(article: ArticleEntity) {
        removeArticleFromFavourites_callCount += 1
    }
    
    func updateArticleListWith(article: ArticleEntity) {
    }
}
