//
//  FavouriteArticlesManagerTest.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-15.
//

import XCTest
@testable import NewsAppKarSpv

class FavouriteArticlesManagerTest: XCTestCase {
    
    // MARK: - Declarations
    var favouritesManager: FavouriteArticlesManager!
    var mockArticlesRepository: MockFavouriteArticlesRAMRepository!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        favouritesManager = FavouriteArticlesManager(onArticleFavouriteStateUpdate: { _, _ in })
        mockArticlesRepository = MockFavouriteArticlesRAMRepository()
        favouritesManager.favouriteArticlesRepository = mockArticlesRepository
    }
    
    override func tearDownWithError() throws {
        favouritesManager = nil
        mockArticlesRepository = nil
        try super.tearDownWithError()
    }
    
    // MARK: - IsFavourite
    func test_isFavourite_whenArticleIsInRepository_returnsTrue() {
      
    }
    
    func test_isFavourite_whenArticleIsNotInRepository_returnsFalse() {
      
    }
    
    // MARK: - changeArticleState
    func test_changeArticleState_whenArticleIsInRepository_removesItFromRepository() {
       
    }
    
    func test_changeArticleState_whenArticleIsNotInRepository_addsItToRepository() {
   
    }
}
