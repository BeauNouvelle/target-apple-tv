//
//  SizeVariant.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// A variant of a `ColorVariant`.
/// Usually relating to a different size of a product in a particular color.
public struct SizeVariant: Decodable {

    /// The name of this variant, of which can be shown to the user.
    let name: String?
    let apn: String?

}
