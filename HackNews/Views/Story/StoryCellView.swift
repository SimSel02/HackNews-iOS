//
//  StoryCellView.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import SwiftUI

struct StoryCellView: View {
    
    let story: Story
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            websiteRow
            titleRow
            infoRow
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}


#Preview {
    StoryCellView(story: PreviewData.sampleStory)
}


extension StoryCellView {
    
    private var websiteRow: some View {
        HStack {
            AsyncImage(url: URL(string: story.favIconUrl ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 15, height: 15)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .frame(width: 15, height: 15)
                    .opacity(0)
            }
            Text(story.hostURL ?? "")
                .font(.subheadline)
                .foregroundStyle(.red)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
    
    private var titleRow: some View {
        HStack() {
            Text(story.title ?? "")
                .font(.title3)
                .bold()
                .lineLimit(2)
        }
    }
    
    private var infoRow: some View {
        HStack(spacing: 15) {
            HStack(spacing: 3) {
                Image(systemName: "person")
                Text(story.author ?? "unknow")
            }
            HStack(spacing: 3) {
                Image(systemName: "bubble.left")
                Text("\(story.numberOfComments ?? 0)")
            }
            HStack(spacing: 3) {
                Image(systemName: "calendar")
                Text(story.time?.dateOnly() ?? "")
            }
        }
        .foregroundStyle(.secondary)
        .font(.caption)
    }
}
