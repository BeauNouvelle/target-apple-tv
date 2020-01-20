//
//  HeroItem.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// Hero items are carouselable items usually shown at the top of the home screen.
struct HeroItem: Decodable, Identifiable {
    var id: String? = UUID().uuidString

    /// What tapping on the `HeroItem` redirects the user to.
    var url: URL?
    /// AN image displayed to the user with imformation showing what this `HeroItem` is about.
    var image: URL?
}
