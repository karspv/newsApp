//
//  FavouriteArticlesRepositoriesFactory.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-13.
//

import Foundation

class FavouriteArticlesRepositoriesFactory {
    
    static func repository() -> ArticlesRepositoryInterface {
        if #available(iOS 13.0, *) {
            guard let sharedFavouriteArticlesSQLRepository = FavouriteArticlesSQLRepository.shared else {
                return FavouriteArticlesRAMRepository.shared
            }
            return sharedFavouriteArticlesSQLRepository
            
        } else {
            return FavouriteArticlesRAMRepository.shared
        }
    }
}
