//
//  NewtworkManager_Tests.swift
//  HackNews_NetworkManager_Tests
//
//  Created by Simone Sella on 15/09/24.
//

import XCTest
@testable import HackNews

final class NewtworkManager_Tests: XCTestCase {

    private var nm: NetworkManager!

    override func setUpWithError() throws {
        nm = NetworkManager()
    }

    override func tearDownWithError() throws {
        nm = nil
    }

    func fetchList_ShouldReturnStoryesTest() async throws {
        // 1 - Arrange
        let listType: ListType = .best
        // 2 - Act
        let stories = try! await nm.fetchList(ofType: listType)
        // 3 - Assert
        XCTAssertGreaterThan(stories.count, 0)
    }
    
    func fetchComments_shouldReturnComments() async throws {
        // 1 - Arrange (array of correct ids)
        let ids = [41511941, 41511245, 41510651, 41512262, 41513323]
        // 2 - Act
        let comments = try! await nm.fetchComments(ids: ids)
        // 3 - Assert
        XCTAssertGreaterThan(comments.count, 0)
    }
    
    func fetchComments_shouldNotReturnComments() async throws {
        // 1 - Arrange (array of incorrect ids)
        let ids = [1, 2, 3, 4, 5]
        // 2 - Act
        let comments = try! await nm.fetchComments(ids: ids)
        // 3 - Assert
        XCTAssertEqual(comments.count, 0)
    }
    
    func fetchStory_shouldReturnStory() async throws {
        // 1 - Arrange (id of a story)
        let id = 41510252
        // 2 - Act
        let story = try! await nm.fetchStory(id: id)
        // 3 - Assert
        XCTAssertEqual(story.type, "story")
    }
    
    func fetchStory_shouldReturnInvalidResponseError() async throws {
        // 1 - Arrange (id of a story)
        let id = 4
        let testError: HTTPError?
        // 2 - Act
        do {
            _ = try await nm.fetchStory(id: id)
        } catch  {
            testError = error as? HTTPError
            // 3 - Assert
            XCTAssertEqual(testError, HTTPError.commentInvalidResponse)
        }
    }
}
