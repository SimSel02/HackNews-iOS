//
//  Favorite.swift
//  HackNews
//
//  Created by Simone Sella on 13/09/24.
//

import SwiftUI
import SwiftData

struct FavouritesListView: View {
    
    @EnvironmentObject var vm: StoriesViewModel
    @Query private var favourites: [Favourite]
    @State private var stories = [Story]()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !favourites.isEmpty {
                    list
                } else {
                    ContentUnavailableView("You don't have favorite stories so far!", systemImage: "star.circle.fill")
                }
            }
            .navigationTitle("Favourites")
        }
        
    }
    
    func fetchStories() async {
        stories = []
        for favourite in favourites {
            guard let story = try? await vm.fetchStory(id: favourite.id) else {
                return
            }
            stories.append(story)
        }
    }
}

#Preview {
    FavouritesListView()
        .environmentObject(StoriesViewModel())
}

extension FavouritesListView {
    private var list: some View {
        List(stories, id: \.id) { story in
            //ZStack is used to hide disclosure indicators
            ZStack {
                StoryCellView(story: story)
                NavigationLink(destination: StoryDetailView(story: story)) {
                    EmptyView()
                }
                .opacity(0)
            }
            .listRowSeparator(.hidden)
            
        }
        .listStyle(.plain)
        .task {
            await fetchStories()
        }
        .refreshable {
            await fetchStories()
        }
    }
}
