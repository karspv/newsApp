//
//  MockSourceListDataModel2.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-31.
//

import Foundation
@testable import NewsAppKarSpv

// swiftlint:disable identifier_name
class MockSourceListDataModel2: SourceListDataModelInterface {
    
    // MARK: - Declarations
    var sourceList: [SourceEntity] = []
    
    var loadSourceList_callCount = 0
    var loadSourceList_onStart_callback: (() -> Void)?
    var loadSourceList_onSuccess_callback: (() -> Void)?
    var loadSourceList_onError_callback: (() -> Void)?
    
    // MARK: - Methods
    func loadData(onStart: @escaping() -> Void,
                  onSuccess: @escaping() -> Void,
                  onError: @escaping() -> Void) {
        
        loadSourceList_callCount += 1
        loadSourceList_onStart_callback = onStart
        loadSourceList_onSuccess_callback = onSuccess
        loadSourceList_onError_callback = onError
    }
}
