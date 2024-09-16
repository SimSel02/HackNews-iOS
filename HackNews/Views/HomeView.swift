//
//  HomeView.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabView {
            StoriesListView(title: "Top Stories", listType: .top)
                .tabItem {
                    Image(systemName: "medal.fill")
                    Text("Top Stories")
                }
            StoriesListView(title: "Best Stories", listType: .best)
                .tabItem {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Best Stories")
                }
            StoriesListView(title: "New Stories", listType: .new)
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("New Stories")
                }
            FavouritesListView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(StoriesViewModel())
}
