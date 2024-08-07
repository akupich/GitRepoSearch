//
//  RepositoryService.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation
import Combine

final class RepositoryService: RepositoryServiceProtocol {
    
    static let pageSize = 10
    
    let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func searchRepositories(for query: String, page: Int, pageSize: Int) -> AnyPublisher<Repositories, NetworkError> {
        let endpoint = Endpoint.repositories(query: query, page: page, per_page: pageSize)
        
        return networker.get(type: Repositories.self,
                             url: endpoint.url,
                             headers: endpoint.headers)
    }

    func getRepository(id: String) -> AnyPublisher<Repository, NetworkError> {
        let endpoint = Endpoint.repository(id: id)
        
        return networker.get(type: Repository.self,
                             url: endpoint.url,
                             headers: endpoint.headers)
    }
}
