//
//  SetArticleFavouriteStateInput.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-30.
//

import Foundation

class SetArticleFavouriteStateInput {
    var article: ArticleEntity
    var shouldBeFavourite: Bool
    
    init(article: ArticleEntity, shouldBeFavourite: Bool) {
        self.article = article
        self.shouldBeFavourite = shouldBeFavourite
    }
}
