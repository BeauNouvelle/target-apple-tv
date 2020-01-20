//
//  ProductListingItem.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit

/// This is essentially a product.
///
/// It has all the usual properties such as price, name, product code, user rating, etc, etc.
///
/// - NOTE: At the time of creation `Product` was already taken.
struct ProductListingItem: Decodable, Identifiable {

    /// A badge is some extra useful visual sugar displayed to the user indicating a kind of status for the product.
    /// These usually indicate the availability of a product, or if there's a current deal in place.
    enum ProductBadge {
        /// Product is available in store only. Unable to be purchased for delivery.
        case inStoreOnly
        /// Product isn't available yet, but will be soon.
        case comingSoon
        /// Product is part of a deal. e.g. "Buy 2 for $15"
        case deals
        /// Can only be purchased online for delivery. e.g. Playground Equiptment.
        case onlineOnly

        var name: String {
            switch self {
            case .inStoreOnly:
                return "In-Store Only"
            case .comingSoon:
                return "Coming Soon"
            case .deals:
                return "Deal"
            case .onlineOnly:
                return "Online Only"
            }
        }

        var textColor: UIColor {
            switch self {
            case .inStoreOnly:
                return #colorLiteral(red: 0.07885525376, green: 0.6292361021, blue: 0.9055711627, alpha: 1)
            case .comingSoon:
                return #colorLiteral(red: 0.5159692168, green: 0.7533734441, blue: 0.1889635623, alpha: 1)
            case .deals, .onlineOnly:
                return .targetRed
            }
        }
    }

    var id: String = UUID().uuidString

    /// The name of this product.
    let name: String?
    /// Variants are a kind of product too, so this value may be different to `baseProductCode` if this product is a variant of another.
    let code: String
    /// A unique product code based on the root product. So not a variant.
    /// - NOTE: You can tell if this product is a variant by comparing `code` and `baseProductCode`.
    let baseProductCode: String
    /// The current price of the product. This can display a range, depending on the range of prices in the products variants. If any.
    let formattedPrice: String?
    /// If there's been a price reduction, this will contain the before price of the product.
    let formattedWasPrice: String?
    /// A high res image of this product.
    let primaryImageUrl: URL?
    /// Average rating from all customers who have left a review.
    let averageRating: Float?
    /// Used as a kind of product status. Displaying availability, or if the product has a price reduction, etc.
    /// Calculated based on a few rules applied locally. See `ProductListingItem` implementation for details.
    let badge: ProductBadge?
    /// A list of variants associated with this product. e.g. different style, size, color, etc.
    let productVariantDataList: [ProductListingVariant]?

    enum CodingKeys: String, CodingKey {
        case name
        case code
        case baseProductCode
        case formattedPrice
        case formattedWasPrice
        case primaryImageUrl
        case averageRating
        case productVariantDataList

        // For calculating badge value
        case maxAvailOnlineQty
        case maxAvailStoreQty
        case onlineExclusive
        case preview
        case dealDescription
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try? container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        baseProductCode = try container.decode(String.self, forKey: .baseProductCode)
        formattedPrice = try? container.decode(String.self, forKey: .formattedPrice)
        formattedWasPrice = try? "Was " + container.decode(String.self, forKey: .formattedWasPrice)
        primaryImageUrl = try? container.decode(URL.self, forKey: .primaryImageUrl)
        averageRating = try? container.decode(Float.self, forKey: .averageRating)
        productVariantDataList = try? container.decode([ProductListingVariant].self, forKey: .productVariantDataList)

        let maxAvailOnlineQty = (try? container.decode(Int.self, forKey: .maxAvailOnlineQty)) ?? 0
        let maxAvailStoreQty = (try? container.decode(Int.self, forKey: .maxAvailStoreQty)) ?? 0
        let onlineExclusive = try? container.decode(Bool.self, forKey: .onlineExclusive)
        let preview = try? container.decode(Bool.self, forKey: .preview)
        let dealDescription = try? container.decode(String.self, forKey: .dealDescription)

        if maxAvailOnlineQty == 0 && maxAvailStoreQty > 0 && onlineExclusive == false && preview == false {
            badge = .inStoreOnly
        } else if productVariantDataList?.first?.productDisplayType == "COMING_SOON" {
            badge = .comingSoon
        } else if dealDescription != nil {
            badge = .deals
        } else if onlineExclusive == true {
            badge = .onlineOnly
        } else {
            badge = nil
        }

    }

}
