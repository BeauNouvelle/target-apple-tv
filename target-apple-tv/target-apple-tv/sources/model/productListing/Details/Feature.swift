//
//  Feature.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

/// A product feature.
public struct Feature: Decodable {
    /// The name of the feature.
    let name: String?
    /// A description of the feature.
    let value: [String]?

}
