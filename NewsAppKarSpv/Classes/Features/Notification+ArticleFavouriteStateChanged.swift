//
//  Notification+ArticleFavouriteStateChanged.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-28.
//

import Foundation

extension Notification {
    
    final class ArticleFavouriteStateChanged: NotificationPostable {
        
        // MARK: - Declarations
        let article: ArticleEntity
        let favouriteState: ArticleFavouriteState
        
        // MARK: - Methods
        init(article: ArticleEntity, favouriteState: ArticleFavouriteState) {
            self.article = article
            self.favouriteState = favouriteState
        }
    }
}
