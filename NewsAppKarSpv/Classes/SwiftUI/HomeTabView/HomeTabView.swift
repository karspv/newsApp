//
//  HomeTabView.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-07-08.
//

import SwiftUI

struct ArticlesFavourtesView: UIViewControllerRepresentable {
        
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: FavouriteArticleListViewController())
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}

struct HomeTabView: View {
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            SourceListView().tabItem {
                Image(systemName: "house")
                Text("home")
            }.tag(0)
            ArticlesFavourtesView().tabItem {
                Image(systemName: "star")
                Text("star")
            }.tag(1)
            Color.red.tabItem {
                Image(systemName: "car")
                Text("car")
            }.tag(2)
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
