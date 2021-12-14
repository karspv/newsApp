//
//  SourceArticleView.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import SwiftUI

struct SourceArticleView: View {
    
    @ObservedObject var articleViewModel: ArticleViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(articleViewModel.article.title)
                    .bold()
                    .lineLimit(2)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                Spacer()
                Button(action: {
                    articleViewModel.changeArticleFavouriteState()
                    
                }, label: {
                    Image(articleViewModel.buttonImageName)
                        .resizable()
                        .frame(width: 40, height: 40)
                })
            }
            
            Text(articleViewModel.article.description)
                .lineLimit(.none)
                .font(.system(size: 15))
                .foregroundColor(.black)
            
            Text(articleViewModel.formatedDate())
                .lineLimit(1)
                .font(.system(size: 10))
                .foregroundColor(.gray)
            
        }.padding(10)
    }
}

struct SourceArticleView_Previews: PreviewProvider {
    static var previews: some View {
        SourceArticleView(articleViewModel: ArticleViewModel(article: ArticleEntity.mock(id: "Id", title: "title")))
            .previewLayout(.sizeThatFits)
    }
}
