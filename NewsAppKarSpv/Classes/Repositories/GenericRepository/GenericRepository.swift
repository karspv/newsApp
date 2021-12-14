//
//  GenericRepository.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-15.
//

import KeychainSwift
import Foundation
import UIKit

protocol GenericRepositoryInterface {
    func applicationLaunchCount() -> Int
    func increaseLaunchCountBy(amount: Int)
    func resetLaunchCount()
    
    func userSecret() -> String?
    func saveUserSecret(secret: String)
    func clearUserSecret()
}

class GenericRepository: GenericRepositoryInterface {
    
    // MARK: - Constants
    let kApplicationLaunchCountKey: String = "applicationLaunchCountKey"
    let kUserSecretKey: String = "userSecretKey"
    
    // MARK: - Declarations
    let keychain = KeychainSwift()
    var userDefaults: UserDefaults
    
    // MARK: - Dependencies
    static let shared = GenericRepository(userDefaults: UserDefaults.standard)
    
    // MARK: - Methods
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    // MARK: - UserDefaults - Application launch count
    func applicationLaunchCount() -> Int {
        return userDefaults.integer(forKey: kApplicationLaunchCountKey)
    }
    
    func increaseLaunchCountBy(amount: Int) {
        var launchCount = applicationLaunchCount()
        launchCount += amount
        userDefaults.set(launchCount, forKey: kApplicationLaunchCountKey)
    }
    
    func resetLaunchCount() {
        userDefaults.removeObject(forKey: kApplicationLaunchCountKey)
    }
    
    // MARK: - Keychain - User secrets
    func userSecret() -> String? {
        return keychain.get(kUserSecretKey)
    }
    
    func saveUserSecret(secret: String) {
        keychain.set(secret, forKey: kUserSecretKey, withAccess: .accessibleAfterFirstUnlock)
    }
    
    func clearUserSecret() {
        keychain.delete(kUserSecretKey)
    }
}
