//
//  MockSourceListOperationFactory.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-07.
//

import Foundation

protocol SourceListOperationFactoryInterface {
    func operation() -> GetSourceListOperationInterface
}

// swiftlint:disable identifier_name
class MockSourceListOperationFactory: SourceListOperationFactoryInterface {
    
    var mockOperationList: [MockGetSourceListOperation] = []
    
    var mockGetSourceListOperation = MockGetSourceListOperation(output: GetSourceListOutput())
    var operation_callCount: Int = 0
    
    func operation() -> GetSourceListOperationInterface {
        if operation_callCount < mockOperationList.count {
            operation_callCount += 1
            return mockOperationList[operation_callCount - 1]
        } else {
            operation_callCount += 1
            return mockGetSourceListOperation
        }
    }
}
