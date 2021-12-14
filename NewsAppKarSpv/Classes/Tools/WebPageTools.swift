//
//  WebPageTools.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-28.
//

import Foundation
import WebKit

class WebPageTools {
    
    static func showWebPageFor(url: String, in webView: WKWebView) {
        guard let url: URL = NSURL(string: url) as URL? else {
            print("ERROR! Could not get url!")
            return
        }
        webView.load(NSURLRequest(url: url) as URLRequest)
    }
}
