//
//  StoryDetailView.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import SwiftUI
import SwiftData
import OSLog

struct StoryDetailView: View {
    
    @EnvironmentObject var vm: StoriesViewModel
    @Environment(\.modelContext) var contex
    @Query var favourites: [Favourite]
    @State private var isFavourite: Bool = true
    @State private var isShowingSafariViewController: Bool = false
    @State private var isShowingErrorAlert: Bool = false
    @State private var error: HTTPError? = nil
    private let logger = Logger()
    
    let story: Story
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.quinary)
                .ignoresSafeArea()
            VStack {
                header
                CommentsView()
            }
            .navigationTitle("Story")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            favouriteButton
        }
        .sheet(isPresented: $isShowingSafariViewController) {
            if let url = URL(string: story.urlString ?? "") {
                SFSafariView(url: url)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .alert(isPresented: $isShowingErrorAlert, error: error) {
            Button("Ok"){}
        }
        .task {
            do {
                try await vm.fetchComments(ids: story.commentsIds ?? [])
            } catch {
                self.error = error as? HTTPError
                isShowingErrorAlert.toggle()
            }
        }
        .onAppear {
            isFavourite = favourites.map{ $0.id }.contains{ $0 == story.id }
        }
    }
}


#Preview {
    NavigationStack {
        StoryDetailView(story: PreviewData.sampleStory)
            .environmentObject(StoriesViewModel())
    }
}


extension StoryDetailView {
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(story.title ?? "")
                .font(.title2)
                .bold()
                .lineLimit(3)
            infoStack
            if story.hostURL != "" {
                goToWebsiteButton
            }
        }
        .padding()
    }
    
    private var infoStack: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Written by:")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                Text(story.author ?? "unknow")
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Posted on:")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                Text(story.time?.dateOnly() ?? "")
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Comments:")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                Text(story.numberOfComments?.formatted() ?? "0")
                    .font(.headline)
            }
        }
    }
    
    private var goToWebsiteButton: some View {
        Button() {
            isShowingSafariViewController.toggle()
        } label: {
            HStack {
                Image(systemName: "safari")
                Text("Go to website")
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(.white)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var favouriteButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                if !isFavourite {
                    contex.insert(Favourite(id: story.id))
                    try? contex.save()
                    isFavourite.toggle()
                    logger.info("Story (with id: \(story.id)) has been added to favorites")
                } else {
                    let deletePredicate = #Predicate<Favourite> { favourite in
                        favourite.id == story.id
                    }
                    try? contex.delete(model: Favourite.self, where: deletePredicate)
                    try? contex.save()
                    isFavourite.toggle()
                    logger.info("Story (with id: \(story.id)) has been removed from favorites")
                }
            } label: {
                Image(systemName: isFavourite ? "star.fill" : "star")
                    .foregroundStyle(isFavourite ? .red : .secondary)
            }
        }
    }
}
