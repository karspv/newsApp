//
//  NotificationCenter+NotificationPostable.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-29.
//
//  Is depending on: `TSMThreadSafetyTools.swift`
//

import Foundation

extension NotificationCenter {
    func post(_ postable: NotificationPostable, sender: Any? = nil) {
        dispatch_main_sync_safe {
            self.post(postable.notification(sender: sender))
        }
    }
}

extension NotificationPostable {
    fileprivate func notification(sender: Any?) -> Notification {
        return Notification(name: Self.name, object: sender, userInfo: [Self.name: self])
    }
}
