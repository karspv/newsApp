//
//  SourceApiClient.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-08.
//

import Foundation

protocol SourceApiClientInterface {
    func loadSourceList(onSuccess: @escaping([SourceEntity]) -> Void,
                        onError: @escaping() -> Void)
}

class SourceApiClient: SourceApiClientInterface {
    
    // MARK: - Declarations
    var operationQueue = OperationQueue()
    
    // MARK: - Methods
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    func loadSourceList(onSuccess: @escaping([SourceEntity]) -> Void,
                        onError: @escaping() -> Void) {
        let operation = GetSourceListOperation()
        
        operation.completionBlock = {
            
            dispatch_main_sync_safe {
                guard operation.output().isSuccessful else {
                    print("INFO! Operation output was not successful: \(operation.output().isSuccessful)")
                    onError()
                    return
                }
                onSuccess(operation.output().sourceList)
            }
        }
        self.operationQueue.addOperation(operation)
    }
}
