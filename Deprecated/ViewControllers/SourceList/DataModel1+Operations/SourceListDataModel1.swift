//
//  SourceListDataModel.swift
//  NewsAppKarSpv
//
//  Created by Admin on 2021-03-02.
//

import Foundation

class SourceListDataModel1: SourceListDataModelInterface {
    
    // MARK: - Declarations
    var sourceList: [SourceEntity] = []
    var operationFactory: SourceListOperationFactoryInterface = SourceListOperationFactory()
    var operationQueue = OperationQueue()
    var isLoading: Bool = false
    
    // MARK: - Methods
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    func loadData(onStart: @escaping() -> Void,
                  onSuccess: @escaping() -> Void,
                  onError: @escaping() -> Void) {
        
        guard isLoading == false else {
            return
        }
        isLoading = true
        onStart()
        
        let operation: GetSourceListOperationInterface = operationFactory.operation()
        
        operation.completionBlock = { [weak self] in
            DispatchQueue.mainSyncSafe {
                self?.isLoading = false
                
                guard operation.output().isSuccessful else {
                    print("INFO! Operation output was not successful: \(operation.output().isSuccessful)")
                    onError()
                    return
                }
                self?.sourceList = operation.output().sourceList
                onSuccess()
            }
        }
        operationQueue.addOperation(operation)
    }
}
