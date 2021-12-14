//
//  SourceListDataModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-08.
//

import Foundation

protocol SourceListDataModelInterface {
    var sourceList: [SourceEntity] { get }
    
    func loadData(onStart: @escaping() -> Void,
                  onSuccess: @escaping() -> Void,
                  onError: @escaping() -> Void)
}

class SourceListDataModel: SourceListDataModelInterface {
    
    // MARK: - Declarations
    var sourceList: [SourceEntity] = []
    var isLoading: Bool = false
    
    // MARK: - Dependencies
    var sourceApiClient: SourceApiClientInterface = SourceApiClient()
    
    // MARK: - Methods
    func loadData(onStart: @escaping() -> Void,
                  onSuccess: @escaping() -> Void,
                  onError: @escaping() -> Void) {
        guard isLoading == false else {
            return
        }
        isLoading = true
        onStart()
        
        sourceApiClient.loadSourceList(onSuccess: { [weak self] (sourceList: [SourceEntity]) in
            dispatch_main_sync_safe {
                guard let self = self else { return }
                self.sourceList = sourceList
                self.isLoading = false
                onSuccess()
            }
            
        }, onError: { [weak self] in
            dispatch_main_sync_safe {
                self?.isLoading = false
                onError()
            }
        })
    }
}
