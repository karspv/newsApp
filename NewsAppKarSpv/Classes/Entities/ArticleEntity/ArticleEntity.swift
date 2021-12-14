//
//  ArticleEntity.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-05.
//

import Foundation
import GRDB

class ArticleEntity: Equatable, Codable, CustomStringConvertible {
    
    // MARK: - Declarations
    var id: String
    var title: String
    var articleDescription: String?
    var urlToImage: URL?
    var publishDate: Date?
    var content: String?
    var urlToArticle: URL?
    
    var description: String {
        return "id: \(id), title: \(title)"
    }
    
    // MARK: - Methods
    init(id: String, title: String, description: String?, urlToImage: URL?, publishedDate: Date?, content: String?, urlToArticle: URL?) {
        
        self.id = id
        self.title = title
        self.articleDescription = description
        self.urlToImage = urlToImage
        self.publishDate = publishedDate
        self.content = content
        self.urlToArticle = urlToArticle
    }
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String else {
            print("ERROR! No title in dict: \(dictionary)")
            return nil
        }
        guard let urlString = dictionary["url"] as? String else {
            print("ERROR! No URL in dict: \(dictionary)")
            return nil
        }
        self.title = title
        self.id = urlString
        
        articleDescription = dictionary["description"] as? String ?? ""
        urlToImage = (dictionary["urlToImage"] as? String)?.urlFromString()
        publishDate = DateFormatterTools.dateFrom(iso8601String: dictionary["publishedAt"] as? String)
        content = dictionary["content"] as? String ?? ""
        urlToArticle = urlString.urlFromString()
    }
    
    static func articleListFrom(dictList: [[String: Any]]) -> [ArticleEntity] {
        var articleList: [ArticleEntity] = []
        
        for articleDict in dictList {
            guard let article = ArticleEntity(dictionary: articleDict) else {
                print("ERROR! Could not create Article from: \(articleDict)")
                continue
            }
            articleList.append(article)
        }
        return articleList
    }
    
    // MARK: - Equatable
    static func == (lhs: ArticleEntity, rhs: ArticleEntity) -> Bool {
        return lhs.id == rhs.id
    }
}
