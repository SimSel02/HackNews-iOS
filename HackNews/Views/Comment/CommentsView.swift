//
//  CommentsView.swift
//  HackNews
//
//  Created by Simone Sella on 15/09/24.
//

import SwiftUI

struct CommentsView: View {
    
    @EnvironmentObject var vm: StoriesViewModel
    
    var body: some View {
        //comment.0 = The comment
        //comment.1 = The comment's replies
        List(vm.comments, id: \.0) { comment in
            VStack {
                CommentCellView(comment: comment.0)
                ForEach(comment.1, id: \.id) { reply in
                    HStack {
                        Spacer(minLength: 25)
                        Image(systemName: "arrow.turn.down.right")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.secondary)
                        CommentCellView(comment: reply)
                    }
                }
            }
        }.listStyle(.plain)
    }
}

#Preview {
    CommentsView()
}
