//
//  AnalyticsManager.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-07.
//

import Foundation

class AnalyticsManager {
    
    // MARK: - Declarations
    static let shared = AnalyticsManager()

    private var analyticsClientList: [AnalyticsInterface] = [FirebaseAnalytics()]
    
    // MARK: - Methods
    func logEvent(eventKey: EventKeys, withParameters parameters: [String: Any]? = nil) {
        for client in analyticsClientList {
            client.logEvent(eventKey: eventKey.rawValue, withParameters: parameters)
        }
    }
}

// Onboarder comment: Additional step to the solution:
// call logEvent and do a huge switch calling different Analytic tools in different cases
