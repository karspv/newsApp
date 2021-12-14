//
//  ArticleListTableViewCellConfiguration.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-14.
//

import Foundation
import UIKit

class ArticleListTableViewCellConfiguration {
    
    // MARK: - Declarations
    var article: ArticleEntity
    var favouriteState: ArticleFavouriteState
    var onFavouriteButtonTap: (() -> Void)
    
    // MARK: - Methods
    init(article: ArticleEntity,
         favouriteState: ArticleFavouriteState,
         onFavouriteButtonTap: @escaping (() -> Void)) {
        self.article = article
        self.favouriteState = favouriteState
        self.onFavouriteButtonTap = onFavouriteButtonTap
    }
}
