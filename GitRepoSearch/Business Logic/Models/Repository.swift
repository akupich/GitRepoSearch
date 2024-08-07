//
//  Repository.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation

struct Repository: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let html_url: String
    let stargazers_count: Int?
    let description: String?
    let full_name: String?
    let numberOfForks: Int?
}

extension Repository {
    static func fake() -> Self {
        return Repository(id: 123,
                          name: "AFNetworking",
                          html_url: "https://api.github.com/repository/AFNetworking",
                          stargazers_count: 999,
                          description: "Networking framework for iOS",
                          full_name: "AFNetworking/AFNetworking",
                          numberOfForks: 77777)
    }
}
