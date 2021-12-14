//
//  BaseViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-20.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
