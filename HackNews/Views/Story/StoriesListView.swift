//
//  StoriesListView.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import SwiftUI

struct StoriesListView: View {
    
    @EnvironmentObject var vm: StoriesViewModel
    @State private var error: HTTPError? = nil
    @State private var isShowingErrorAlert: Bool = false
    
    let title: String
    let listType: ListType
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if vm.isFetchingStories {
                    LoadingView()
                } else {
                    list
                }
            }
            .navigationTitle(title)
        }
        .task {
            do {
                try await vm.fetchStories(for: listType)
            } catch {
                self.error = error as? HTTPError
                isShowingErrorAlert.toggle()
            }
        }
        .alert(isPresented: $isShowingErrorAlert, error: error) {
            Button("Refresh") {
                vm.refresh(list: listType)
            }
        }
    }
}

#Preview {
    StoriesListView(title: "Top Stories", listType: .best)
        .environmentObject(StoriesViewModel())
}

extension StoriesListView {
    private var list: some View {
        List(vm.stories, id: \.id) { story in
            //ZStack is used to hide system disclosure indicators
            ZStack {
                StoryCellView(story: story)
                NavigationLink(destination: StoryDetailView(story: story)) {
                    EmptyView()
                }
                .opacity(0)
            }
            .listRowSeparator(.hidden)
        }
        .listRowSpacing(-10)
        .listStyle(.plain)
        .refreshable {
            vm.refresh(list: listType)
        }
    }
}



