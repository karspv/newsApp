//
//  CustomNavigationViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-20.
//

import Foundation
import UIKit

class CustomNavigationViewController: UINavigationController {
    
    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}
