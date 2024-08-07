//
//  RepositoryServiceProtocol.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 14.09.2021.
//

import Foundation
import Combine

/// Methods that helps to get more information about repositories
protocol RepositoryServiceProtocol: AnyObject {
    
    /// Tool used to acceess remote data
    var networker: NetworkerProtocol { get }
    
    /**
     Search for repositories by passed keyword
     
     - Parameters:
        - query: Keyword used for searching
        - page: Number of page of results list
        - pageSize: Count of items on single page
     
     - Returns: Publisher with Repositories object or Network error
     */
    func searchRepositories(for query: String,
                            page: Int,
                            pageSize: Int) -> AnyPublisher<Repositories, NetworkError>
    
    /**
     Get repository details by it''s id
     
     - Parameters:
        - id: Id of repository
     
     - Returns: Publisher with decoded type of data or Network error
     */
    func getRepository(id: String) -> AnyPublisher<Repository, NetworkError>
}

extension RepositoryServiceProtocol {
    func searchRepositories(for query: String, page: Int) -> AnyPublisher<Repositories, NetworkError> {
        self.searchRepositories(for: query, page: page, pageSize: RepositoryService.pageSize)
    }
}
