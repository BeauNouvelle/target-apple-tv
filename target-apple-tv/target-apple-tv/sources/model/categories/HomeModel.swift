//
//  HomeModel.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Contains items for display on the home screen pulled from the Home API.
struct HomeModel: Decodable {

    let heroItems: [HeroItem]?
    /// A list of product categories.
    /// If a user taps on one they should be taken to a product list showing items within that category.
    let categoryItems: [CategoryItem]?

    enum CodingKeys: String, CodingKey {
        case categoryItems = "CategoryItems"
        case heroItems = "HeroItems"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryItems = try? values.decode([CategoryItem].self, forKey: .categoryItems)
        heroItems = try? values.decode([HeroItem].self, forKey: .heroItems).filter { $0.image != nil && $0.url != nil }
    }

}
