//
//  Endpoint+Repos.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation

extension Endpoint {
    
    static var repositories: Self {
        return Endpoint(path: "/repositories")
    }
    
    static func repositories(query: String, sorting: String = "stars", page: Int, per_page: Int = 10) -> Self {
        return Endpoint(path: "/repositories", queryItems: [
            URLQueryItem(name: "q", value: "\(query)"),
            URLQueryItem(name: "sort", value: sorting),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(per_page))
        ])
    }
    
    static func repository(id: String) -> Self {
        return Endpoint(path: "/repository/\(id)")
    }
}
