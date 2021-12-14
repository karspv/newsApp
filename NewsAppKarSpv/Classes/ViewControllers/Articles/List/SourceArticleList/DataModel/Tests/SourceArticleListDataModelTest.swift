//
//  SourceArticleListDataModelTest.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-13.
//

import XCTest
@testable import NewsAppKarSpv

class SourceArticleListDataModelTest: XCTestCase {
    
    // MARK: - Declarations
    var dataModel: SourceArticleListDataModel!
    var mockArticleApiClient: MockArticleApiClient!
    var mockFavouriteArticlesManager: MockFavouriteArticlesManager!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataModel = SourceArticleListDataModel(source: SourceEntity(id: "id1",
                                                                    title: "title1",
                                                                    description: "description1"),
                                               onArticleListFiltered: {},
                                               onArticleFavouriteStateUpdate: { _, _ in })
        
        mockArticleApiClient = MockArticleApiClient()
        dataModel.articleApiClient = mockArticleApiClient
        
        mockFavouriteArticlesManager = MockFavouriteArticlesManager()
        dataModel.favouriteArticlesManager = mockFavouriteArticlesManager
    }
    
    override func tearDownWithError() throws {
        dataModel = nil
        mockArticleApiClient = nil
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
