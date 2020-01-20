//
//  ProductDetailsService.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

struct ProductDetailsService {

    typealias ProductDetailsResult = Result<ProductDetails, HTTPError>
    private static let apiHost = "https://www.target.com.au"


    /// Use this function to pass through a scanned bardcode. Two networks calls are made together.
    /// ProductDetails, this includes a description, title, images and variants.
    /// StockDetails, this includes title, and stock information for nearby stores.
    ///
    /// - Parameter productCode: The barcode of the product scanned.
    static func product(productCode: String, completion: @escaping ((ProductDetailsResult) -> Void)) {

        guard let detailsUrl = detailsUrl(productCode: productCode) else {
            // URL errors will be returned immediately.
            completion(.failure(.invalidURL))
            return
        }

        // Details
        let detailsRequest = URLRequest(url: detailsUrl)

        HTTPService.perform(detailsRequest, decode: ProductDetails.self) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let details):
                completion(.success(details))
            }
        }
    }

    private static func detailsUrl(productCode: String) -> URL? {
        var components = URLComponents(string: apiHost)
        let detailsPath = "/p/\(productCode)/json"
        components?.path = detailsPath
        return components?.url
    }

}
