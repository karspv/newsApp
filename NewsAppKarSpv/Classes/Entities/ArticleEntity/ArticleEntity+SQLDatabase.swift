//
//  ArticleEntity+SQLDatabase.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-07.
//

import Foundation
import GRDB

private let kFavouriteArticlesSQLRepositoryTableName: String = "favouriteArticles"

extension ArticleEntity: FetchableRecord, PersistableRecord, MutablePersistableRecord, TableRecord {
    
    static var databaseTableName: String = kFavouriteArticlesSQLRepositoryTableName
    
    enum Columns: String, CodingKey {
        case id
        case title
        case articleDescription
        case urlToImage
        case publishDate
        case content
        case urlToArticle
    }
}
