//
//  ColorVariant.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// A variant of a particular product usually relating to different colors, although not exclusively.
/// In some cases a `ColorVariant` could be a different model, fit, or style.
public struct ColorVariant: Decodable {

    /// The name of this particular variant.
    let name: String?
    /// The color, in human readable text, of this variant.
    let colour: String?
    /// Usually contains a list of sizes for this particular variant. Although `sizeVariant` isn't a completely accurate name.
    let sizeVariants: [SizeVariant]?
    /// Images of this variant
    let media: [Media]?
    /// This seems to only be available when the product has no sizes.
    let apn: String?
}
