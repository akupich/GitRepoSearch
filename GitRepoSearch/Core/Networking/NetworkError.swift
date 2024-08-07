//
//  NetworkError.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation

enum NetworkError: Error {
    case sessionFailed(error: URLError)
    case decodingFailed
    case other(Error)
}

extension NetworkError {
    init(_ error: Error) {
        switch error {
        case is Swift.DecodingError:
          self = .decodingFailed
        case let urlError as URLError:
          self = .sessionFailed(error: urlError)
        default:
          self = .other(error)
        }
    }
}
