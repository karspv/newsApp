//
//  MockSourceApiClient.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-30.
//

import Foundation
@testable import NewsAppKarSpv

// swiftlint:disable identifier_name
class MockSourceApiClient: SourceApiClientInterface {
    
    var loadSourceList_callCount = 0
    var loadSourceList_onSuccess_callback: (([SourceEntity]) -> Void)?
    var loadSourceList_onError_callback: (() -> Void)?
    
    func loadSourceList(onSuccess: @escaping ([SourceEntity]) -> Void,
                        onError: @escaping () -> Void) {
        loadSourceList_callCount += 1
        loadSourceList_onSuccess_callback = onSuccess
        loadSourceList_onError_callback = onError
    }
}
