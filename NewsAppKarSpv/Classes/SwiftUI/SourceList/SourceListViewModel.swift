//
//  SourceListViewModel.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import Foundation

/// Published - del live updates
class SourceViewDataModel: ObservableObject {
    
    //    @Published var sourceList: [SourceEntity] = [
    //        SourceEntity(id: UUID().uuidString, title: "title", description: "description"),
    //        SourceEntity(id: UUID().uuidString, title: "title2", description: "description2"),
    //        SourceEntity(id: UUID().uuidString, title: "title3", description: "description3")
    //    ]
    //
    //    init() {
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    //            self.sourceList = [
    //                SourceEntity(id: UUID().uuidString, title: "xxx", description: "description"),
    //                SourceEntity(id: UUID().uuidString, title: "xx", description: "description2")
    //            ]
    //            /// Manual update
    //            /// self.objectWillChange.send()
    //        }
    //    }
    
    // MARK: - Declarations
    @Published var sourceList: [SourceEntity] = []
    @Published var isLoading: Bool = false
    
    // MARK: - Dependencies
    var sourceApiClient: SourceApiClientInterface = SourceApiClient()
    
    // MARK: - Methods
    init() {
        loadData()
    }
    
    func loadData() {
        guard isLoading == false else {
            return
        }
        isLoading = true
        
        sourceApiClient.loadSourceList(onSuccess: { [weak self] (sourceList: [SourceEntity]) in
            dispatch_main_sync_safe {
                guard let self = self else { return }
                self.sourceList = sourceList
                self.isLoading = false
            }
            
        }, onError: { [weak self] in
            dispatch_main_sync_safe {
                self?.isLoading = false
            }
        })
    }
}
