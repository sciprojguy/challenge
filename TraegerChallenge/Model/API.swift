//
//  API.swift
//  TraegerChallenge
//
//  Created by Admin on 10/24/21.
//

import Foundation

let apiKey = "ykYBNZJ4MkXOy6cD3WweruRBDKumopMkYPxcAvvT"

public enum HTTPError: LocalizedError {
    case statusCode(Int)
    case noResponse
    case badUrl
}

public enum FetchProgress {
    case idle
    case inProgress
    case succeeded
    case failed(Error)
}
