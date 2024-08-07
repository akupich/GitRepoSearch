//
//  Repositories.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation

struct Repositories: Codable {
    let total_count: Int
    let incomplete_results: Bool
    var items: [Repository]
    
    static var empty: Self {
        return .init(total_count: 0, incomplete_results: false, items: [])
    }
}
