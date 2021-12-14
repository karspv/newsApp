//
//  AppDelegate+Appearance.swift
//  NewsAppKarSpv
//
//  Created by Admin on 2021-04-21.
//

import Foundation
import UIKit
import KeychainSwift

extension AppDelegate {
    
    // MARK: - Appearance
    func setupAppAppearance() {
        setupNavigationBarAppearance()
        UITabBar.appearance().tintColor = UIColor.black
    }
    
    func setupNavigationBarAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.white
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    
    // MARK: - Application launch
    func updateApplicationLaunchCount() {
        let genericRepository: GenericRepositoryInterface = GenericRepository.shared
        
        if genericRepository.applicationLaunchCount() == 0 {
            print("App launched for the first time")
            genericRepository.clearUserSecret()
            
        } else if genericRepository.applicationLaunchCount() == 1 {
            genericRepository.saveUserSecret(secret: "TOP SECRET")
        }
        
        genericRepository.increaseLaunchCountBy(amount: 1)
    }
}
