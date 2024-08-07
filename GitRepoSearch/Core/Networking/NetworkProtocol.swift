//
//  NetworkProtocol.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 14.09.2021.
//

import Foundation
import Combine

/// Interface that represents service for fetiching data
protocol NetworkerProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    /**
     Get requested decoded objects of passed type from concrete url.
     
     - Parameters:
        - type: Type of requested data
        - url: Path where data is located
        - headers: The headers neeed for request
     
     - Returns: Publisher with decoded type of data or Network error
     */
    func get<T>(type: T.Type,
                url: URL,
                headers: Headers) -> AnyPublisher<T, NetworkError> where T: Decodable
    
    /**
     Get requested data from exact url.
     
     - Parameters:
        - url: Path where data is located
        - headers: The headers neeed for request
     
     - Returns: Publisher with received data or URLError error
     */
    func getData(url: URL, headers: Headers) -> AnyPublisher<Data, URLError>
}
