//
//  CommentCellView.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import SwiftUI

struct CommentCellView: View {
    
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "person")
                Text(comment.author ?? "unknow")
                Spacer()
                Image(systemName: "calendar")
                Text(comment.time?.dateOnly() ?? "")
            }
            .font(.callout)
            .foregroundStyle(.secondary)

            Text(String(comment.text?.html2String ?? ""))
                .font(.subheadline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CommentCellView(comment: PreviewData.sampleComment)
}
