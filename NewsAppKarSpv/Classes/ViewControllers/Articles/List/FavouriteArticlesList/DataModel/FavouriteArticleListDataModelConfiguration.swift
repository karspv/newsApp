//
//  FavouriteArticleListDataModelConfiguration.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-01.
//

import Foundation

class FavouriteArticleListDataModelConfiguration {
    
    // MARK: - Declarations
    var onArticleUpdateFavouriteState: (_ articleIndex: Int, _ favouriteState: ArticleFavouriteState) -> Void?
    var onArticleAddedToArticleList: (_ articleIndex: Int) -> Void?
    var onArticleRemovedFromArticleList: (_ articleIndex: Int) -> Void?
    var onArticleListRearrange: () -> Void?
    
    // MARK: - Methods
    init(onArticleUpdateFavouriteState: @escaping (_ articleIndex: Int, _ favouriteState: ArticleFavouriteState) -> Void?,
         onArticleAddedToArticleList: @escaping (_ articleIndex: Int) -> Void?,
         onArticleRemovedFromArticleList: @escaping (_ articleIndex: Int) -> Void?,
         onArticleListRearrange: @escaping () -> Void?) {
        
        self.onArticleUpdateFavouriteState = onArticleUpdateFavouriteState
        self.onArticleAddedToArticleList = onArticleAddedToArticleList
        self.onArticleRemovedFromArticleList = onArticleRemovedFromArticleList
        self.onArticleListRearrange = onArticleListRearrange
    }
}
