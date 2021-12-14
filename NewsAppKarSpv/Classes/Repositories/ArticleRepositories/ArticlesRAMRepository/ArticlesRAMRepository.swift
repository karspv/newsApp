//
//  BaseArticlesRepository.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-05.
//

import Foundation

class ArticlesRAMRepository: ArticlesRepositoryInterface {
    
    // MARK: - Declarations
    private(set) var baseArticleList: [ArticleEntity] = []
    
    // MARK: - Methods
    func articleList() -> [ArticleEntity] {
        return baseArticleList
    }
    
    func updateArticleListWith(article: ArticleEntity) {
        articleList().contains(article) ? removeAllArticlesMatching(article: article) : add(article: article)
    }
    
    // MARK: - Helpers
    private func add(article: ArticleEntity) {
        guard articleList().contains(article) == false else {
            return
        }
        baseArticleList.append(article)
    }
    
    private func removeAllArticlesMatching(article: ArticleEntity) {
        baseArticleList = baseArticleList.filter { $0 != article }
    }
}
