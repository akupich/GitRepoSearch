//
//  GitRepoSearchTests.swift
//  GitRepoSearchTests
//
//  Created by Andriy Kupich on 13.09.2021.
//

import XCTest
import Combine
@testable import GitRepoSearch

class GitRepoSearchTests: XCTestCase {
    
    var sut: SearchRepoViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        cancellables = []
    }
    
    func test_searchedResultsReturnedOnTextTyped() throws {
        // Arrange
        let mockedRepos = Repositories(total_count: 100, incomplete_results: false, items: [Repository.fake()])
        let mockedService = RepositoryServiceMock(data: mockedRepos)
        sut = SearchRepoViewModel(repositoryService: mockedService)
        let expectation = expectation(description: "State changed")
        
        sut.$state
            .filter { !$0.repos.items.isEmpty }
            .first()
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Act
        sut.onAppear()
        sut.searchText = "test"
        
        // Assert
        XCTAssertTrue(sut.repositories.isEmpty)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(
            sut.repositories == mockedRepos.items,
            "Repositories expected to be \(mockedRepos.items), but are equal to \(sut.repositories)"
        )
    }
    
    func test_searchedResultsClearedOnTextRemoved() throws {
        // Arrange
        let repos = Repositories(total_count: 100, incomplete_results: false, items: [Repository.fake()])
        let state = SearchRepoViewModel.State(repos: repos)
        sut = SearchRepoViewModel(state: state)
        let expectation = expectation(description: "State changed")
        
        sut.$state
            .dropFirst()
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Act
        sut.onAppear()
        sut.searchText = ""
        
        // Assert
        XCTAssertFalse(sut.repositories.isEmpty)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(
            sut.repositories.isEmpty,
            "Repositories expected to be empty when there is no text in search field"
        )
    }
}
