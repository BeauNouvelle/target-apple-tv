//
//  ProductDetails.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Extended information about a product including images, ratings, long description and different variants.
public struct ProductDetails: Decodable {
    let product: Product
}

struct Product: Decodable {
    let code: String
    let name: String
    let description: String
    let brand: String
    let targetVariantProductListerData: [VariantData]?
}

struct VariantData: Decodable {
    let images: [Media]
}
