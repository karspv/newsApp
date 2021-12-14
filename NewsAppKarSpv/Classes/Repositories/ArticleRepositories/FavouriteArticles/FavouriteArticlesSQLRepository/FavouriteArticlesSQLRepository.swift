//
//  FavouriteArticlesSQLRepository.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-07.
//

import GRDB
import Foundation

class FavouriteArticlesSQLRepository: ArticlesRepositoryInterface {
    
    // MARK: - Constants
    static let kSQLFolderName: String = "SQLDatabase"
    static let kSQLDatabaseFileName: String = "favouriteArticles.sqlite"
    
    // MARK: - Declarations
    static let shared = sharedSQLRepository()
    let dbQueue: DatabaseQueue
    
    // MARK: - Methods
    init(_ dbQueue: DatabaseQueue) throws {
        self.dbQueue = dbQueue
        try migrator().migrate(dbQueue)
    }

    static func sharedSQLRepository() -> FavouriteArticlesSQLRepository? {
        do {
            guard let dataBaseUrlPath = sqlDataBaseUrl()?.path else {
                return nil
            }
            
            let dbQueue = try DatabaseQueue(path: dataBaseUrlPath)
            let appDatabase = try FavouriteArticlesSQLRepository(dbQueue)
            return appDatabase
            
        } catch {
            print("ERROR! Could not create shared SQLDatabase, error: \(error)")
            return nil
        }
    }
    
    static func sqlDataBaseUrl() -> URL? {
        do {
            let fileManager = FileManager()
            let folderURL: URL = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(kSQLFolderName, isDirectory: true)
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            var dbURL: URL = folderURL.appendingPathComponent(kSQLDatabaseFileName)
            
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            try dbURL.setResourceValues(resourceValues)

            return dbURL
            
        } catch {
            print("ERROR! Could not create url for sql data base, error: \(error)")
            return nil
        }
    }
    
    // MARK: - Helpers
    func migrator() -> DatabaseMigrator {
        var migrator = DatabaseMigrator()
        migrator.eraseDatabaseOnSchemaChange = true
        migrator.registerMigration("createFavouriteArticlesV1") { (db: Database) in
            try db.create(table: ArticleEntity.databaseTableName) { (table: TableDefinition) in
                
                table.column(ArticleEntity.Columns.id.stringValue, .text).notNull().primaryKey()
                table.column(ArticleEntity.Columns.title.stringValue, .text).notNull()
                table.column(ArticleEntity.Columns.articleDescription.stringValue, .text)
                table.column(ArticleEntity.Columns.urlToImage.stringValue, .text)
                table.column(ArticleEntity.Columns.publishDate.stringValue, .date)
                table.column(ArticleEntity.Columns.content.stringValue, .text)
                table.column(ArticleEntity.Columns.urlToArticle.stringValue, .text)
            }
        }
        return migrator
    }
}
