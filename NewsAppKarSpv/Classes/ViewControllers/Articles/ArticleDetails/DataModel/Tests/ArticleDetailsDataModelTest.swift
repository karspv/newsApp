//
//  ArticleDetailsDataModelTest.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-09.
//

import XCTest
@testable import NewsAppKarSpv

class ArticleDetailsDataModelTest: XCTestCase {
    
    // MARK: - Declarations
    var dataModel: ArticleDetailsDataModel!
    
    // MARK: - Dependencies
    var articleApiClient: ArticleApiClientInterface = ArticleApiClient()
    var mockFavouriteArticlesManager: MockFavouriteArticlesManager!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataModel = ArticleDetailsDataModel(article: ArticleEntity.mock(id: "id1", title: "title1"),
                                            onArtileFavouriteStateUpdate: { _ in })
                
        mockFavouriteArticlesManager = MockFavouriteArticlesManager()
        dataModel.favouriteArticlesManager = mockFavouriteArticlesManager
    }
    
    override func tearDownWithError() throws {
        dataModel = nil
        mockFavouriteArticlesManager = nil
        try super.tearDownWithError()
    }
    
    // MARK: - changeArticleFavouriteState
    func test_changeArticleFavouriteState_callsManagerToChangeState() {
    }
    
    // MARK: - IsFavourite
    func test_isFavouriteArticle_returnsIsFavouriteFromManager() {
    }
}
