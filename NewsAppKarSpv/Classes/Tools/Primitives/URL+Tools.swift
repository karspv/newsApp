//
//  URL+Tools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-23.
//

import Foundation
import UIKit

extension URL {
    
    func openUrlInExternalBrowser() {
        UIApplication.shared.open(self)
    }
}
