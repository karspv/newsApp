//
//  MockFavouriteArticlesManager.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-14.
//

import Foundation
@testable import NewsAppKarSpv

// swiftlint:disable identifier_name
class MockFavouriteArticlesManager: FavouriteArticlesManagerInterface {

    // MARK: - Declarations
    var changeArticleState_callCount = 0
    var changeArticleState_article: ArticleEntity?
    
    var isFavourite_callCount = 0
    var isFavourite_mockReturn: Bool = true
    
    // MARK: - Dependencies
    var mockfavouriteArticlesRepository: ArticlesRepositoryInterface = FavouriteArticlesRAMRepository.shared
    
    // MARK: - Methods
    func changeArticleState(article: ArticleEntity) {
        changeArticleState_article = article
        changeArticleState_callCount += 1
    }
    
    func isFavourite(article: ArticleEntity) -> Bool {
        isFavourite_callCount += 1
        return isFavourite_mockReturn
    }
    
    func favouriteArticleList() -> [ArticleEntity] {
        return [ArticleEntity.dummyMock()]
    }
    
    func changeArticleState(article: ArticleEntity,
                            onStart: @escaping () -> Void,
                            onSuccess: @escaping () -> Void,
                            onError: @escaping () -> Void) {
    }
    
    func favouriteStateFor(article: ArticleEntity) -> ArticleFavouriteState {
        return .notFavourite
    }
}
