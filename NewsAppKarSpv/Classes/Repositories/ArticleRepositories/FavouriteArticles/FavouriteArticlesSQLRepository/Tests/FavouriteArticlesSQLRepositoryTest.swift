//
//  FavouriteArticlesSQLRepositoryTest.swift
//  NewsAppKarSpvTests
//
//  Created by Karolis on 2021-05-07.
//

import GRDB
import XCTest
@testable import NewsAppKarSpv

class FavouriteArticlesSQLRepositoryTest: ArticlesRepositoryInterfaceTests {
    
    // MARK: - Constants
    let kSQLTestFolderName: String = "SQLTestDatabase"
    let kSQLTestDatabaseFileName: String = "SQLTestDatabase.sqlite"
    
    // MARK: - Declarations
    var appDatabase: FavouriteArticlesSQLRepository!
    
    // MARK: - Methods
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        appDatabase = favouriteArticlesSQLRepository()
        favouriteArticlesRepository = appDatabase
    }
    
    override func tearDownWithError() throws {
        try appDatabase?.dbQueue.erase()
        
        try super.tearDownWithError()
    }
    
    // MARK: - Helpers
    func favouriteArticlesSQLRepository() -> FavouriteArticlesSQLRepository {
        do {
            let dbQueue = try DatabaseQueue(path: sqlDataBaseUrl().path)
            let appDatabase = try FavouriteArticlesSQLRepository(dbQueue)
            return appDatabase
        } catch {
            fatalError("ERROR! Could not create shared SQLDatabase, error: \(error)")
        }
    }
    
    func sqlDataBaseUrl() -> URL {
        do {
            let fileManager = FileManager()
            let folderURL: URL = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(kSQLTestFolderName, isDirectory: true)
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            let dbURL: URL = folderURL.appendingPathComponent(kSQLTestDatabaseFileName)
            return dbURL
        } catch {
            fatalError("ERROR! Could not create url for sql data base, error: \(error)")
        }
    }
}
