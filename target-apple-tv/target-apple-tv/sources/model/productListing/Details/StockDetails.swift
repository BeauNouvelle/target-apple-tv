//
//  StockDetails.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Represents the stock information of a particular product for a number of nearby stores.
public struct StockDetails : Decodable {

    /// The current price of this product to be displayed to the user.
    let price: String?
    /// The name of this product to be displayed to the user.
    let name: String?
    /// A Target product code. Usually this isn't shown to the user, but they can use this code (if known) to search for this product.
    let productCode: String?
    /// Indicates if this product is avaiable online only.
    let onlineStock: Bool?
    /// List of nearby stores and their stock levels for this product.
    let stores: [StoreStockLevel]?

}
