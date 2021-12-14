//
//  FavouriteArticlesRepositoryTests.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-19.
//

import XCTest
@testable import NewsAppKarSpv

// swiftlint:disable orphaned_doc_comment
class ArticlesRepositoryInterfaceTests: XCTestCase {
    
    // MARK: - Declarations
    var favouriteArticlesRepository: ArticlesRepositoryInterface!
    
    override func perform(_ run: XCTestRun) {
        /// This DISABLES these tests for this class instance
        /// These tests should not run on it's own, instead they MUST be overriden by CONCRETE classes.
        /// When overriding, initialise repository in setup method, e.g.:
        //
        //        override func setUpWithError() throws {
        //            repository = FavouriteArticlesRepository()
        //        }
        //
        
        if type(of: self) != ArticlesRepositoryInterfaceTests.self {
            super.perform(run)
        }
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        favouriteArticlesRepository = nil
        try super.tearDownWithError()
    }
    
    func test_add_savesInRepository() {
//        let article = ArticleEntity.mock(id: "a", title: "")
//        favouriteArticlesRepository.add(article: article)
//
//        XCTAssertEqual(favouriteArticlesRepository.articleList(), [article])
//
//        let article2 = ArticleEntity.mock(id: "ab", title: "")
//        favouriteArticlesRepository.add(article: article2)
//
//        XCTAssertEqual(favouriteArticlesRepository.articleList(), [article, article2])
    }
    
    func test_add_allowsSavingSameArticleTwice() {
//        let article = ArticleEntity.mock(id: "a", title: "")
//
//        favouriteArticlesRepository.add(article: article)
//        favouriteArticlesRepository.add(article: article)
//
//        XCTAssertNotEqual(favouriteArticlesRepository.articleList(), [article, article])
    }
    
    func test_remove_removesFromRepository() {
//        favouriteArticlesRepository.add(article: ArticleEntity.mock(id: "a", title: ""))
//        favouriteArticlesRepository.add(article: ArticleEntity.mock(id: "b", title: ""))
//        favouriteArticlesRepository.removeAllArticlesMatching(article: ArticleEntity.mock(id: "a", title: ""))
//
//        XCTAssertEqual(favouriteArticlesRepository.articleList(), [ArticleEntity.mock(id: "b", title: "")])
    }
    
    func test_remove_whenArticleIsNotIn_doesNothing() {
//        let article = ArticleEntity.mock(id: "a", title: "")
//
//        favouriteArticlesRepository.removeAllArticlesMatching(article: article)
//
//        XCTAssertEqual(favouriteArticlesRepository.articleList(), [])
    }
    
    func test_remove_whenHaveSeveralIsntances_removesAllOfThem() {
//        favouriteArticlesRepository.add(article: ArticleEntity.mock(id: "a", title: ""))
//        favouriteArticlesRepository.add(article: ArticleEntity.mock(id: "b", title: ""))
//        favouriteArticlesRepository.add(article: ArticleEntity.mock(id: "a", title: ""))
//        favouriteArticlesRepository.removeAllArticlesMatching(article: ArticleEntity.mock(id: "a", title: ""))
//
//        XCTAssertEqual(favouriteArticlesRepository.articleList(), [ArticleEntity.mock(id: "b", title: "")])
    }
}
