//
//  GenericRepositoryTest.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-04-16.
//

import XCTest
@testable import NewsAppKarSpv

class GenericRepositoryTest: XCTestCase {
    
    // MARK: - Declarations
    var userDefaults: UserDefaults!
    var genericRepository: GenericRepositoryInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userDefaults = UserDefaults(suiteName: "test")
        genericRepository = GenericRepository(userDefaults: userDefaults)
    }
    
    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: "test")
        try super.tearDownWithError()
    }
    
    func test_increaseLaunchCountByAmount_increasesLaunchCountInRepository() {
        genericRepository.increaseLaunchCountBy(amount: 1)
        XCTAssertEqual(genericRepository.applicationLaunchCount(), 1)
        
        genericRepository.increaseLaunchCountBy(amount: 1)
        XCTAssertEqual(genericRepository.applicationLaunchCount(), 2)
    }
    
    func test_applicationLaunchCount_retrievesStoredLaunchCountFromRepository() {
        genericRepository.increaseLaunchCountBy(amount: 1)
        XCTAssertNotNil(genericRepository.applicationLaunchCount())
    }
    
    func test_resetLaunchCount_deletesLauchCountFromRepository() {
        genericRepository.increaseLaunchCountBy(amount: 1)
        genericRepository.resetLaunchCount()
        XCTAssertEqual(genericRepository.applicationLaunchCount(), 0)
    }
}
