//
//  DateFormatterTools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-18.
//

import Foundation

class DateFormatterTools {
    
    static var displayableDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter
    }()
    
    static var backEndDateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter
    }()
    
    static func dateFrom(iso8601String: String?) -> Date? {
        guard let iso8601String = iso8601String else {
            return nil
        }
        return backEndDateFormatter.date(from: iso8601String)
    }
    
    static func displayableStringFrom(date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        return displayableDateFormatter.string(from: date)
    }
}
