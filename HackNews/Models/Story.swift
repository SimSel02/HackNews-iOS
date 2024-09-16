//
//  Story.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import Foundation


struct Story: Codable {
    
    let id: Int
    let type: String?
    let author: String?
    let title: String?
    let time: Date?
    let urlString: String?
    let commentsIds: [Int]?
    let numberOfComments: Int?
    
    var hostURL: String? {
        let url = URL(string: urlString ?? "")
        return url?.host() ?? ""
    }
    var favIconUrl: String? {
        let url = "https://www.google.com/s2/favicons?sz=32&domain=\(hostURL ?? "")"
        return url
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case author = "by"
        case title = "title"
        case time = "time"
        case urlString = "url"
        case commentsIds = "kids"
        case numberOfComments = "descendants"
    }
}
