//
//  FavouriteArticlesRepositoryTest.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-15.
//

import XCTest
@testable import NewsAppKarSpv

class FavouriteArticlesRAMRepositoryTest: ArticlesRepositoryInterfaceTests {
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        favouriteArticlesRepository = FavouriteArticlesRAMRepository()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
}
