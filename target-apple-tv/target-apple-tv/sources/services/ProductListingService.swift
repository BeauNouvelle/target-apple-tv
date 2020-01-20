//
//  ProductListingService.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Responsible for fetching a list of products from the product listing API.
/// Will return products and their associated variants.
struct ProductListingService {

    static let apiHost = "https://app.target.com"

    typealias ProductListingResult = Result<ProductListing, HTTPError>

    /// A query type that the ProductListingService can use to construct the appropriate requests.
    ///
    /// - categoryID: Typically used for fetching the first screen of products for a particular category.
    /// - query: A full text query
    /// - pagePath: If you have a path extention to a particular product page, you can pass it in here to fetch those products.
    enum ProductListingQueryParameter {
        case categoryID(id: String)
        case brandID(id: String)
        case search(query: String)
        case searchPath(path: String)
        case path(path: String)

        var url: URL? {
            switch self {
            case .categoryID(id: let id):
                let query = URLQueryItem(name: "category", value: id)

                var components = URLComponents(string: apiHost)
                components?.path = "/search"
                components?.queryItems = [query]

                return components?.url
            case .brandID(id: let id):
                let query = URLQueryItem(name: "brand", value: id)

                var components = URLComponents(string: apiHost)
                components?.path = "/search"
                components?.queryItems = [query]

                return components?.url
            case .search(query: let query):
                let fullUrlString = apiHost + "/search?text=" + query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                return URL(string: fullUrlString)
            case .searchPath(path: let path):
                let fullUrlString = apiHost + "/search" + path
                return URL(string: fullUrlString)
            case .path(path: let path):
                let fullUrlString = apiHost + path
                return URL(string: fullUrlString)
            }
        }
    }

    /// Responsible for fetching a list of products from the product listing API.
    /// These will return in the form of a `ProductListing` with properties containing metadata,
    /// queries, facets, and product list.
    /// - Parameter productQueryParameter: A parameter indicating how the query should be constructed. e.g. categoryID, pagePath, etc
    /// - Parameter completion: Will return either an error or ProductListing type.
    static func productListingFor(productQueryParameter: ProductListingQueryParameter, completion: @escaping (ProductListingResult) -> Void) {

        guard let url = productQueryParameter.url else {
            completion(.failure(.invalidURL))
            return
        }
        let request = productListingRequest(url: url)

        HTTPService.perform(request, decode: ProductListing.self) { (result) in
            completion(result)
        }
    }

    /// A single point for creating a request appropriate for calling the product listing API.
    /// - Parameter url: The URL to use with the request.
    private static func productListingRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }

}
