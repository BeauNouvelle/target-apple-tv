//
//  ProductListing.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// A container object returned from the product listing api.
/// Holds all the information required to display a list of products, and apply sorting/filtering.
struct ProductListing: Decodable {

    /// All basic information pertaining to the number of results returned, number of pages, and number of products.
    let metadata: ProductListingMetadata
    /// A list of products returned from the query!
    let products: [ProductListingItem]

    private enum CodingKeys: String, CodingKey {
        case data = "data"
        case metadata = "commonData"
        case sortData = "sortDataList"
        case facets = "facetList"
        case products = "productDataList"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedData = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        metadata = try nestedData.decode(ProductListingMetadata.self, forKey: .metadata)
        products = try nestedData.decode([ProductListingItem].self, forKey: .products)
    }

}
