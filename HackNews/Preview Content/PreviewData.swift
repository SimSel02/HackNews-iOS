//
//  PreviewDataProvider.swift
//  HackNews
//
//  Created by Simone Sella on 12/09/24.
//

import Foundation
import SwiftUI

class PreviewData {
    
    static var sampleStory: Story {
        Story(id: 41510252,
              type: "story",
              author: "notmine1337",
              title: "We spent $20 to achieve RCE and accidentally became the admins of .mobi",
              time: .now,
              urlString: "https://labs.watchtowr.com/we-spent-20-to-achieve-rce-and-accidentally-became-the-admins-of-mobi/",
              commentsIds: [
                41511941,
                41511245,
                41510651,
                41512262,
                41513323,
                41510451,
                41512283,
                41513036,
                41518070,
                41513987,
                41510537,
                41510538,
                41511677,
                41514917,
                41510579,
                41511147,
                41510823,
                41512071,
                41511839,
                41510631,
                41512212,
                41510703,
                41517221,
                41517187,
                41512663,
                41510469,
                41510553,
                41511525,
                41515911,
                41511310,
                41510461,
                41510544,
                41511349,
                41511287,
                41512112,
                41510602,
                41516915,
                41514651,
                41510922
              ], numberOfComments: 366)
    }
    
    static var sampleComment: Comment {
        Comment(id: 41510651, type: "comment", author: "Simone", text: "This is a test comment", time: .now, replyIds: [41512172,
                                                                                                                   41511372,
                                                                                                                   41514799,
                                                                                                                   41513688])
    }
}
