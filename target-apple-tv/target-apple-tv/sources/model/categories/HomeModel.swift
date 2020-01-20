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
        categoryItems = try? values.decode([CategoryItem].self, forKey: .categoryItems).filter { $0.url?.pathComponents[1] == "c" }

        let heros = try? values.decode([HeroItem].self, forKey: .heroItems)

        let shopItems = heros?.filter {
            $0.image != nil && $0.url != nil && $0.url?.pathComponents.count ?? 0 > 1 && $0.url?.pathComponents[1] == "c"

            // with search text.. will avoid for now.
//            $0.image != nil && $0.url != nil && (($0.url?.pathComponents.count ?? 0 > 1 && $0.url?.pathComponents[1] == "c") || ($0.url?.absoluteString.contains("search?text=") == true))
        }

//        let validHeroItems = shopItems?.filter { ($0.url?.absoluteString.contains("search?text=") ?? <#default value#>) }
//
//        if pathComponents.count > 1, pathComponents[1] == "c", let lastPath = pathComponents.last {
//            NavigationService.sharedInstance.navigateToProductListing(with: lastPath, categoryName: "Shop")
//        } else if url.absoluteString.contains("search?text="), let query = url.query {
//            NavigationService.sharedInstance.navigateToProductListing(withPath: "/search?\(query)")
//        }

        heroItems = shopItems
    }

}
