//
//  StoreStockLevel.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Contains information about the stock levels for a particular product at a particular store.
public struct StoreStockLevel: Decodable {

    /// The name of the store. e.g. Chadstone.
    let name: String?
    /// The coordinates for this store.
    let geoPoint: GeoPoint?
    /// User readable text indicating the distance from their location to this store.
    let formattedDistance: String?
    /// A unique assigned number for this store.
    let storeNumber: Int?
    /// The stock level to be displayed to the user. e.g. Low, No Stock, In Stock.
    let stockLevel: String?

}
