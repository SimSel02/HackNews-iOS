//
//  NetworkManager.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import Foundation
import OSLog

/// Takes care of all network comunications.
class NetworkManager: ObservableObject {
    
    //BaseURL
    private var apiUrl = "https://hacker-news.firebaseio.com/v0/"
    
    private let logger = Logger()
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    //MARK: Public functiones
    
    /// Returns the first 50 stories contained in a list
    /// - Parameter ofType: The list type (top, best, new)
    /// - Returns: Array of Story
    /// - Throws: HTTPErrorr with localizedDescription
    func fetchList(ofType listType: ListType) async throws -> [Story] {
        logger.log("Network Manager: Fetching list")
        //Get all story ids of the list
        let ids =  try await fetchIds(forList: listType)
        
        //Task group creates parallel API requests to make fetching much faster
        let stories = try await withThrowingTaskGroup(of: Story.self) { group in
            for id in ids.prefix(50) {
                group.addTask {
                    return try await self.fetchStory(id: id)
                }
            }
            var items = [Story]()
            for try await item in group {
                items.append(item)
            }
            return items
        }
        return stories
    }
    
    /// Returns all comments of a story including its replies
    /// - Parameter ids: An array of ids of a story's comments
    /// - Returns: Array of (Comment, [Comment]) representing (Comment, Replies)
    /// - Throws: HTTPErrorr with localizedDescription
    func fetchComments(ids: [Int]) async throws -> [(Comment, [Comment])] {
        logger.log("Network Manager: Fetching comments and replies")
        var results = [(Comment, [Comment])]()
        //Fetch comments
        let comments = try await withThrowingTaskGroup(of: Comment.self) { group in
            for id in ids {
                group.addTask {
                    return try await self.fetchComment(id: id)
                }
            }
            var items = [Comment]()
            for try await item in group {
                items.append(item)
            }
            return items
        }
        //Fetch replies for each comment
        for comment in comments {
            var replies = [Comment]()
            if let replyIds = comment.replyIds {
                for replyId in replyIds {
                    if let reply = try? await fetchComment(id: replyId) {
                        replies.append(reply)
                    }
                }
            }
            results.append((comment, replies))
        }
        return results
    }
    
    /// Returns a single story
    /// - Parameter id: an id for the api call
    /// - Returns: Story
    /// - Throws: HTTPErrorr with localizedDescription
    func fetchStory(id: Int) async throws -> Story {
        logger.log("Network Manager: Fetching story")
        //Compose URL
        let itemURL = apiUrl + "item/" + "\(id)" + ".json"
        guard let requestUrl = URL(string: itemURL) else {
            logger.error("Error fetching story: storyInvalidURL")
            throw HTTPError.storyInvalidURL
        }
        //Send Request
        let (data, response) = try await URLSession.shared.data(from: requestUrl)
        //Check reponse status
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            logger.error("Error fetching story: storyInvalidResponse")
            throw HTTPError.storyInvalidResponse
        }
        //Decode and return story
        do {
            return try decoder.decode(Story.self, from: data)
        } catch {
            logger.error("Error fetching story: storyInvalidData")
            throw HTTPError.storyInvalidData
        }
    }
    
    
    //MARK: Private Functiones
    
    //Fetch all ids contained in a list
    private func fetchIds(forList list: ListType) async throws -> [Int] {
        logger.log("Network Manager: Fetching ids")
        //Compose URL
        var listEndpoint: String {
            switch list {
            case .best: "beststories"
            case .top: "topstories"
            case .new: "newstories"
            }
        }
        let completeUrlString = apiUrl + listEndpoint + ".json"
        guard let requestUrl = URL(string: completeUrlString) else {
            logger.error("Error fetching story: storyInvalidURL")
            throw HTTPError.storyInvalidURL
        }
        //Send Request
        let (data, response) = try await URLSession.shared.data(from: requestUrl)
        //Check response status
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            logger.error("Error fetching story: storyInvalidResponse")
            throw HTTPError.storyInvalidResponse
        }
        //Decode and return ids
        do {
            return try decoder.decode([Int].self, from: data)
        } catch {
            logger.error("Error fetching story: storyInvalidData")
            throw HTTPError.storyInvalidData
        }
    }
    
    //Fetch a single comment
    private func fetchComment(id: Int) async throws -> Comment {
        logger.log("Network Manager: Fetching comment")
        //Compose url
        let commentUrl = apiUrl + "item/" + "\(id)" + ".json"
        guard let requestUrl = URL(string: commentUrl) else {
            logger.error("Error fetching story: commentInvalidURL")
            throw HTTPError.commentInvalidURL
        }
        //Send request
        let (data, response) = try await URLSession.shared.data(from: requestUrl)
        //Check reponse status
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            logger.error("Error fetching story: commentInvalidResponse")
            throw HTTPError.commentInvalidResponse
        }
        //Decode and return comment
        do {
            return try decoder.decode(Comment.self, from: data)
        } catch {
            logger.error("Error fetching story: storyInvalidData")
            throw HTTPError.commentInvalidData
        }
    }
}
