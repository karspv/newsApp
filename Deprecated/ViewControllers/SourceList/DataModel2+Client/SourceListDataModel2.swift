//
//  SourceListDataModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-24.
//

import Foundation

class SourceListDataModel2: SourceListDataModelInterface {
    
    // MARK: - Declarations
    var sourceList: [SourceEntity] = []
    var isLoading: Bool = false
    
    // MARK: - Dependencies
    var sourceApiClient: SourceApiClientInterface = SourceApiClient2()
    
    // MARK: - Methods
    func loadData(onStart: @escaping() -> Void,
                  onSuccess: @escaping() -> Void,
                  onError: @escaping() -> Void) {
        
        guard isLoading == false else {
            return
        }
        isLoading = true
        
        sourceApiClient.loadSourceList(onStart: {
            DispatchQueue.mainSyncSafe {
                onStart()
            }
        }, onSuccess: { [weak self] (sourceList: [SourceEntity]) in
            DispatchQueue.mainSyncSafe {
                guard let self = self else { return }
                self.sourceList = sourceList
                self.isLoading = false
                onSuccess()
            }
        }, onError: {
            DispatchQueue.mainSyncSafe {
                self.isLoading = false
                onError()
            }
        })
    }
}
