//
//  SourceArticleListView.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import SwiftUI

struct SourceArticleListView: View {
    
    @StateObject var viewModel: SourceArticleListViewModel
    
    var body: some View {
        
            ZStack {
                ScrollView {
                    TextField("search me", text: $viewModel.searchText)

                    LazyVStack(alignment: .leading, spacing: .zero) {
                        ForEach(viewModel.articleList(), id: \.id) { (article: ArticleEntity) in
                            
                            NavigationLink(destination: articleDetailsDestinationWith(article: article)) {
                                SourceArticleView(articleViewModel: ArticleViewModel(article: article))
                            }
                            // FIXME: Pasispaudzia ir button ir celle
                            Divider()
                        }
                    }
                }
                
                if viewModel.isLoading {
                    LoadingIndicatorView()
                }
            }.navigationBarTitle(viewModel.sourceTitle(), displayMode: .large)
    }
    
    // MARK: - Helpers
    private func articleDetailsDestinationWith(article: ArticleEntity) -> ArticleDetailsView {
        let viewModel = ArticleViewModel(article: article)
        return ArticleDetailsView(viewModel: viewModel)
    }
}

struct SourceArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        SourceArticleListView(viewModel: .init(source: .default))
    }
}
