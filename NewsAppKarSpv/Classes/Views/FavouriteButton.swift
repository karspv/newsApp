//
//  FavouriteButton.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-13.
//

import Foundation
import UIKit

class FavouriteButton: UIButton {
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public
    func set(favouriteState: ArticleFavouriteState) {
        switch favouriteState {
        case .favourite:
            markAsFavourite()
            
        case .notFavourite:
            markAsUnFavourite()
            
        case .loading:
            markButtonAsLoading()
        }
    }
    
    // MARK: - Helpers
    func markButtonAsLoading() {
        isEnabled = false
        setBackgroundImage(R.image.loadingStart(), for: .normal)
    }
    
    func markAsFavourite() {
        isEnabled = true
        setBackgroundImage(R.image.favouritedStar(), for: .normal)
    }
    
    func markAsUnFavourite() {
        isEnabled = true
        setBackgroundImage(R.image.unfavouritedStar(), for: .normal)
    }
}
