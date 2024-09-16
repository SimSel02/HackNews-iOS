//
//  StroriesViewModel.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import Foundation
import SwiftData
import OSLog

@MainActor
class StoriesViewModel: ObservableObject {
    
    //Singleton instance
    static var shared = StoriesViewModel()
    private var logger = Logger()
    
    @Published var stories = [Story]()
    @Published var comments = [(Comment, [Comment])]()
    @Published var favorites = [Story]()
    @Published var isFetchingStories: Bool = false
    
    
    private var nm = NetworkManager()
    
    func fetchStory(id: Int) async throws -> Story {
        do {
            return try await nm.fetchStory(id: id)
        } catch {
            throw error
        }
    }
    
    func fetchStories(for listType: ListType) async throws {
        isFetchingStories = true
        do {
            stories = try await nm.fetchList(ofType: listType)
            isFetchingStories = false
        } catch {
            throw error
        }
    }
    
    func fetchComments(ids: [Int]) async throws {
        do {
            comments = try await nm.fetchComments(ids: ids)
        } catch {
            throw error
        }
    }
    
    func refresh(list: ListType) {
        logger.info("StoriesViewModel is refreshing data")
        //Delay is used to avoid navigation stack's title glitch during refresh
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Task {
                do {
                    try await self.fetchStories(for: list)
                } catch {
                    self.logger.error("Error during data refresh: \(error.localizedDescription)")
                    print(error)
                }
            }
        }
    }
}
