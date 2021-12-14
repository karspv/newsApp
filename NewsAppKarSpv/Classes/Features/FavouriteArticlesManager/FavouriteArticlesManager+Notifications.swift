//
//  FavouriteArticlesManager+Notifications.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-05.
//

import Foundation

extension FavouriteArticlesManager {
    
    func postArticleFavouriteStateChangedNotification(article: ArticleEntity, state: ArticleFavouriteState) {
        let notification = Notification.ArticleFavouriteStateChanged(article: article, favouriteState: state)
        notificationCenter.post(notification, sender: self)
    }
    
    @objc func didReceiveArticleFavouriteStateChanged(_ notification: Notification) {
        guard let receivedNotification: Notification.ArticleFavouriteStateChanged = notification.data() else {
            print("ERROR! Notification.ArticleFavouriteStateChanged not inside userInfo: \(String(describing: notification.userInfo))")
            return
        }
        onArticleFavouriteStateUpdate(receivedNotification.article, receivedNotification.favouriteState)
    }
}
