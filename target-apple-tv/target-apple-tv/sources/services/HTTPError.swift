//
//  HTTPError.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Errors returned by `HTTPService`.
public enum HTTPError: Error {

    /// No response return from the request i.e. HTTPURLResponse was nil.
    case noResponse

    /// The responses status code is outside the accepted range. e.g. 200..299
    case unsuccessfulStatusCode(Int)

    /// This usually means an error was returned from the data task, but no other cases for `HTTPError` matched.
    case unknown(message: String)

    /// Data was received but there was a problem decoding it.
    /// Check that your `Decodable` object has been set up correctly, e.g. matching properties, etc.
    case decodeFailed(message: String)

    /// Failed to create a url either standalone or based on components.
    case invalidURL

    /// No internet connection
    case connectivityError

    var title: String {
        switch self {
        case .unsuccessfulStatusCode, .invalidURL, .decodeFailed:
            return "It's not you, it's us"
        case .connectivityError, .noResponse:
            return "Oh no!\nIt looks like you're offline"
        case .unknown:
            return "Oh no!\nIt looks like something went wrong"
        }
    }

    var message: String {
        switch self {
        case .unsuccessfulStatusCode, .invalidURL, .decodeFailed:
            return "We are having some technical issues and we are sorry for the trouble."
        case .connectivityError, .noResponse:
            return "Try to find a WiFi spot or check your connection."
        case .unknown(message: let message):
            return message
        }
    }

}
