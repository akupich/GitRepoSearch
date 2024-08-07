//
//  RepositoryServiceMock.swift
//  GitRepoSearchTests
//
//  Created by Andriy Kupich on 14.09.2021.
//

import Combine

final class RepositoryServiceMock: RepositoryServiceProtocol {
    var networker: NetworkerProtocol {
        return Networker()
    }
    
    var stubbedSearchRepositories: Repositories
    var invokedSearchRepositories = false
    var invokedSearchRepositoriesCount = 0
    
    init(data: Repositories) {
        stubbedSearchRepositories = data
    }
    
    func searchRepositories(for query: String, page: Int, pageSize: Int) -> AnyPublisher<Repositories, NetworkError> {
        invokedSearchRepositories = true
        invokedSearchRepositoriesCount += 1
        
        return Just(stubbedSearchRepositories)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
    }
    
    func getRepository(id: String) -> AnyPublisher<Repository, NetworkError> {
        return Just(stubbedSearchRepositories.items.first!)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
