//
//  ArticleEntity+List.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-18.
//

import Foundation

enum ArticleListSortType: String {
    case title
    case date
    case none
}

extension Array where Element == ArticleEntity {
    
    func sortBy(sortType: ArticleListSortType) -> [ArticleEntity] {
        switch sortType {
        case .date:
            return sorted { compareArticlesByPublishDate(articleA: $0, articleB: $1) }
            
        case .title:
            return sorted { $0.title < $1.title }
            
        case .none:
            return self
        }
    }
    
    func filterBy(query: String?) -> [ArticleEntity] {
        guard let query = query else {
            return self
        }
        
        guard query.isEmpty == false else {
            return self
        }
        
        return filter { $0.title.lowercased().contains(query.lowercased()) ||
            $0.description.lowercased().contains(query.lowercased())
        }
    }
    
    // MARK: - Helpers
    private func compareArticlesByPublishDate(articleA: ArticleEntity, articleB: ArticleEntity) -> Bool {
        guard let publishDateA: Date = articleA.publishDate else {
            return false
        }
        
        guard let publishDateB: Date = articleB.publishDate else {
            return true
        }
        return publishDateA > publishDateB
    }
}
