//
//  SourceListView.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import SwiftUI

/// EnviromentObject - yra kazkieno kito objektas sukurtas ir paduotas
/// StateObject - yra mano paties sukurtas ir ji galiu kitam paduoti
/// ObservedObject - jis gali buti ir mano sukurtas ir paduotas, kuris ant reload nusiresettina

struct SourceListView: View {
    
    @StateObject private var viewModel = SourceViewDataModel()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: .zero) {
                        ForEach(viewModel.sourceList, id: \.id) { (source: SourceEntity) in
                            NavigationLink(destination: sourceArticleDestinationWith(source: source)) {
                                SourceView(source: source)
                            }.isDetailLink(true)
                            
                            Divider()
                        }
                    }
                }
                
                if viewModel.isLoading {
                    LoadingIndicatorView()
                }
            }.navigationBarTitle("Sources", displayMode: .large)
        }
    }
    
    // MARK: - Helpers
    private func sourceArticleDestinationWith(source: SourceEntity) -> SourceArticleListView {
        let viewModel = SourceArticleListViewModel(source: source)
        return SourceArticleListView(viewModel: viewModel)
    }
}

struct SourceListView_Previews: PreviewProvider {
    static var previews: some View {
        SourceListView()
    }
}
