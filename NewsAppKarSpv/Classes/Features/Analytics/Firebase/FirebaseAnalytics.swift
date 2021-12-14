//
//  FirebaseAnalytics.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-08.
//

import Foundation
import Firebase

class FirebaseAnalytics: AnalyticsInterface {
    
    // MARK: - Methods
    func logEvent(eventKey: String, withParameters parameters: [String: Any]? = nil) {
        Analytics.logEvent(eventKey, parameters: parameters)
    }
}
