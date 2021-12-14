//
//  AnalyticsInterface.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-08.
//

import Foundation

protocol AnalyticsInterface {
    func logEvent(eventKey: String, withParameters parameters: [String: Any]?)
}
