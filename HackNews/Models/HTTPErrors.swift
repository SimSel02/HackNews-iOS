//
//  HTTPErrors.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import Foundation

enum HTTPError: Error {
    case storyInvalidData
    case storyInvalidResponse
    case storyInvalidURL
    case commentInvalidData
    case commentInvalidResponse
    case commentInvalidURL
}

extension HTTPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .storyInvalidData:
            return "Ops, couldn't load stories (Invalid data)"
        case .storyInvalidResponse:
            return "Ops, couldn't load stories (Invalid response)"
        case .storyInvalidURL:
            return "Ops, couldn't load stories (Invalid Url)"
        case .commentInvalidData:
            return "Ops, couldn't load comments (Invalid data)"
        case .commentInvalidResponse:
            return "Ops, couldn't load comments (Invalid response)"
        case .commentInvalidURL:
            return "Ops, couldn't load comments (Invalid Url)"
        }
    }
}
