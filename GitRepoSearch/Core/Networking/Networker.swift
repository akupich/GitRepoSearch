//
//  Networker.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation
import Combine

final class Networker: NetworkerProtocol {
    
    func get<T>(type: T.Type,
                url: URL,
                headers: Headers) -> AnyPublisher<T, NetworkError> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { .init($0) }
            .eraseToAnyPublisher()
    }
    
    func getData(url: URL, headers: Headers) -> AnyPublisher<Data, URLError> {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
