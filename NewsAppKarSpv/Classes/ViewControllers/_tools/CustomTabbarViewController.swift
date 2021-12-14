//
//  CustomTabbarViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-20.
//

import Foundation
import UIKit

class CustomTabbarViewController: UITabBarController {
    
    override var shouldAutorotate: Bool {
        return selectedViewController?.shouldAutorotate ?? true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return selectedViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return selectedViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}
