//
//  DefaultAuthenticationChallenger.swift
//  NewsAppErgBlg
//
//  Created by Admin on 2020-09-10.
//  Copyright © 2020 TeleSoftas. All rights reserved.
//

import Foundation

class DefaultAuthenticationChallenger: AuthenticationChallenger {
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.performDefaultHandling, nil)
    }
}
