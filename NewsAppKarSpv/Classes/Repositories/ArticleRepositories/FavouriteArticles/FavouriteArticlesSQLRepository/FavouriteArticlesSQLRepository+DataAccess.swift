//
//  FavouriteArticlesSQLRepository+DataAccess.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-07.
//

import Foundation
import GRDB

extension FavouriteArticlesSQLRepository {
    
    // MARK: - Public methods
    func articleList() -> [ArticleEntity] {
        do {
            let articleList: [ArticleEntity] = try dbQueue.read { (db: Database) in
                try ArticleEntity.fetchAll(db)
            }
            return articleList
        } catch {
            print("ERROR! Could not get articleList from sql database!: \(error)")
            return []
        }
    }
    
    func updateArticleListWith(article: ArticleEntity) {
        articleList().contains(article) ? removeAllArticlesMatching(article: article) : add(article: article)
    }
    
    // MARK: - Helpers
    private func add(article: ArticleEntity) {
        do {
            try dbQueue.write { (db: Database) in
                try article.save(db)
            }
        } catch {
            print("ERROR! Could not save article: \(article) to sql database!: \(error)")
        }
    }
    
    private func removeAllArticlesMatching(article: ArticleEntity) {
        do {
            try dbQueue.write { (db: Database) in
                _ = try ArticleEntity.deleteOne(db, key: article.id)
            }
        } catch {
            print("ERROR! Could not delete article: \(article) from sql database!: \(error)")
        }
    }
}
