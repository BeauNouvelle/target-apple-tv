//
//  CategoryTile.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

struct CategoryTile: View {

    let category: CategoryItem
    @State private var backgroundColor = Color.clear

    var body: some View {
        ZStack {
            KFImage(category.image)
            VStack {
                Text(category.title)
            }
        }.focusable(true) { isFocused in
            self.backgroundColor = isFocused ? Color.green : Color.clear
        }
        .background(self.backgroundColor)
    }
}
