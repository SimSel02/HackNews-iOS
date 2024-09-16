//
//  Comment.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import Foundation

struct Comment: Codable, Hashable {
    let id: Int
    let type: String?
    let author: String?
    let text: String?
    let time: Date?
    let replyIds: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case author = "by"
        case text = "text"
        case time = "time"
        case replyIds = "kids"
    }
}
