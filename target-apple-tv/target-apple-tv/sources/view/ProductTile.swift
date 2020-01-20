//
//  ProductTile.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import SwiftUI

struct ProductTile: View {

    let product: ProductListingItem
    @State private var backgroundColor = Color.clear

    var body: some View {
        ZStack {
            Image("some url")
            VStack {
                Text(product.name ?? "")
            }
        }.focusable(true, onFocusChange: { (isFocused) in
            self.backgroundColor = isFocused ? Color.green : Color.clear
            }).background(self.backgroundColor)
    }
}
