//
//  ProductListingVariant.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// A variant on a particular product. e.g. Different color, or size.
struct ProductListingVariant: Decodable {

    /// Indicates the products status for display purposes. e.g. "COMING_SOON"
    let productDisplayType: String?
}
