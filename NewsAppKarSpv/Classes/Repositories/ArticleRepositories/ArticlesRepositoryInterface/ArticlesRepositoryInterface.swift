//
//  ArticlesRepositoryInterface.swift
//  NewsAppKarSpv
//
//  Created by Admin on 2021-04-16.
//

import Foundation

protocol ArticlesRepositoryInterface {
    func articleList() -> [ArticleEntity]
    func updateArticleListWith(article: ArticleEntity)
}
