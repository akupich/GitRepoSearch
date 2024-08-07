//
//  Endpoint+URL.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return ["Content-Type": "application/json"]
    }
}
