//
//  WebPageViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-28.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    
    // MARK: - Constants
    let kGoogleUrl: String = "https://www.google.com/"
    
    // MARK: - Declarations
    @IBOutlet private weak var webView: WKWebView!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.webPage()
        
        WebPageTools.showWebPageFor(url: kGoogleUrl, in: webView)
    }
}
