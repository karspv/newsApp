//
//  Notification+NotificationPostable.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-29.
//

import Foundation

extension Notification {
    func data<T: NotificationPostable>() -> T? {
        return userInfo?[T.name] as? T
    }
}
