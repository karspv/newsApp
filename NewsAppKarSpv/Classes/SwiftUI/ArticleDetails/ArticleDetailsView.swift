//
//  ArticleDetailsView.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleDetailsView: View {
    
    @StateObject var viewModel: ArticleViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.formatedDate())
                
                HStack {
                    Text(viewModel.article.title)
                        .bold()
                        .lineLimit(.none)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                    Spacer()
                    Button(action: {
                        viewModel.changeArticleFavouriteState()
                        
                    }, label: {
                        Image(viewModel.buttonImageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                }
                
                if viewModel.imageUrl != nil {
                    WebImage(url: viewModel.imageUrl)
                        .resizable()
                        .scaledToFit()
                }
                
                if let content = viewModel.article.content {
                    Text(content)
                        .lineLimit(.none)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                }
                Text(viewModel.article.description)
                    .lineLimit(.none)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
                Button(action: {
                    viewModel.openUrl()
                }, label: {
                    
                    ZStack {
                        Capsule().foregroundColor(Color.blue)
                        Text("Learn more")
                            .foregroundColor(.white)
                            .padding()
                    }
                }).frame(maxWidth: .infinity, maxHeight: 50)
            }
        }.padding()
        .navigationTitle(viewModel.article.title)
    }
}

struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailsView(
            viewModel: ArticleViewModel(
                article: ArticleEntity.mock(id: "id",
                                            title: "title")))
    }
}
