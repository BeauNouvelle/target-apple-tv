//
//  HTTPService.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// A generic wrapper around URLSession for performing requests.
struct HTTPService {
    /// default URL session
    static func defaultSession() -> URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15
        sessionConfig.timeoutIntervalForResource = 60

        return URLSession(configuration: sessionConfig)
    }

    /// A generic wrapper around URLSession for performing network requests.
    /// Handles error handling and decoding of any objects conforming to the Decodable protocol.
    ///
    /// - Parameters:
    ///   - request: The url request you wish to make.
    ///   - decode: Pass in the type of object you wish to have decoded from the get response.
    ///   - result: Returns either a decoded object, or HTTPError.
    static func perform<T: Decodable>(_ request: URLRequest, decode: T.Type, result: @escaping (Result<T, HTTPError>) -> Void) {

        let session = HTTPService.defaultSession()
        let task = session.dataTask(with: request.requestWithTargetHeaders()) { (data, response, error) in

            if let error = error {
                if error.isConnectivityError {
                    result(.failure(.connectivityError))
                    return
                }
                result(.failure(.unknown(message: error.localizedDescription)))
                return
            }

            guard let response = response as? HTTPURLResponse, let data = data else {
                result(.failure(.noResponse))
                return
            }

            guard statusCodeIsValid(for: response) else {
                result(.failure(.unsuccessfulStatusCode(response.statusCode)))
                return
            }

//            let jsonData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            print(jsonData)

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                result(.success(decodedData))
            } catch let error {
                print(error)
                result(.failure(.decodeFailed(message: error.localizedDescription)))
            }
            return
        }

        task.resume()
        session.finishTasksAndInvalidate()
    }

    /// Perform network request, return `HTTPURLResponse` if and only if request status code is between 200 and 299.
    /// - Parameters:
    ///   - request: an URLRequest object
    ///   - result: Returns either a `HTTPURLResponse`, or `HTTPError`.
    static func perform(_ request: URLRequest, result: @escaping (Result<HTTPURLResponse, HTTPError>) -> Void) {
        let session = HTTPService.defaultSession()
        let task = session.dataTask(with: request.requestWithTargetHeaders()) { (data, response, error) in

            guard let response = response as? HTTPURLResponse else {
                result(.failure(.noResponse))
                return
            }

            guard statusCodeIsValid(for: response) else {
                result(.failure(.unsuccessfulStatusCode(response.statusCode)))
                return
            }

            result(.success(response))
            return
        }

        task.resume()
        session.finishTasksAndInvalidate()
    }

    private static var successCodes: Range<Int> = 200..<299

    /// Checks if the status code for the provided response is within the `successCodes` range.
    private static func statusCodeIsValid(for httpResponse: HTTPURLResponse) -> Bool {
        guard successCodes.contains(httpResponse.statusCode) else {
            return false
        }
        return true
    }

}
