//
//  NotificationPostable.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-29.
//

import Foundation

protocol NotificationPostable {
    /// By default it be a class name which implements this protocol
    static var name: Notification.Name { get }
}

extension NotificationPostable {
    static var name: Notification.Name {
        return Notification.Name(String(describing: self))
    }
}
