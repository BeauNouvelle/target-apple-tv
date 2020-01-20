//
//  ProductListingMetadata.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Information on a particular product listing request.
/// Contains information such as the next page url, and total number of results.
///
/// `ProductListingMetadata` is usually returned as a property on a `ProductListing` instance,
/// which will usually have details about sort options, facets, and lists of products.
struct ProductListingMetadata: Decodable {

    /// Used for pulling a list of products from the next page. When doing so, another `ProductListing` is returned with metadata,
    /// containing a url to the next page after that.
    let nextPageUrl: String?
    /// The current page number. Starts at zero.
    let currentPage: Int?
    /// When resetting filters, this is the url to call.
    let resetUrl: String?
    /// The text the user searched to perform the query.
    /// This will be nil if the PLP was queried with no search term. i.e. with a category instead.
    let searchText: String?
    /// The corrected search text. If the user made a spelling mistake when performing a search on the PLP, this will show the correction.
    /// This will be nil if the PLP was queried with no search term. i.e. with a category instead.
    let correctedSearchText: String?

    var searchResultsHeaderText: String? {
        if let originalSearch = searchText, let correctedText = correctedSearchText {
            return "Nothing found for \"\(originalSearch)\", showing results for \"\(correctedText)\" instead."
        }
        return nil
    }
}
