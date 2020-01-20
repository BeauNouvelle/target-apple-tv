//
//  CategoryItem.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Represents a product category, genrally used on the home screen. e.g. Men, Women, Kids, Toys, etc.
struct CategoryItem: Identifiable, Decodable {
    var id: String? = UUID().uuidString

    /// Link to the category screen.
    /// This URL is used to present a webview/native screen showing a list of products that fall under this category.
    let url: URL?
    /// The name of this category. e.g. Women, Men, etc.
    let title: String
    /// A small thumbnail image representation of the category.
    let image: URL?

    func categoryId() -> String? {
        return url?.lastPathComponent
    }
}
