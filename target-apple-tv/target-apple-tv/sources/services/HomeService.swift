//
//  HomeService.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Fetches a few of the top standard items on the home screen that don't contain any specific user content.
struct HomeService {

    static let apiHost = "https://app.target.com.au"
    typealias HomeModelResult = Result<HomeModel, HTTPError>

    /// Responsible for fetching all the standard items on the home screen that don't require extra parameters. HeroItems, Categories, LookItems, etc.
    ///
    /// - Parameter completion: A wrapper around various HomeItem arrays.
    static func homeModel(completion: @escaping (HomeModelResult) -> Void) {

        guard var components = URLComponents(string: apiHost) else {
            completion(.failure(.invalidURL))
            return
        }

        components.path = "/navigation/home"

        let heroCountQuery = URLQueryItem(name: "countOfHeroItems", value: "0")
        let includeHeroListQuery = URLQueryItem(name: "includeHeroList", value: "false")
        let includeCategories = URLQueryItem(name: "includeCategories", value: "true")
        let includeLookItems = URLQueryItem(name: "includeLookItems", value: "false")
        let shouldSmartSort = URLQueryItem(name: "smartSort", value: "true")

        let queryItems = [heroCountQuery, includeHeroListQuery, includeCategories, includeLookItems, shouldSmartSort]
        components.queryItems = queryItems

        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        HTTPService.perform(request, decode: HomeModel.self) { (result) in
            completion(result)
        }
    }

}
