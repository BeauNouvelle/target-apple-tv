//
//  UICollectionReusableView+Identifier.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionReusableView {

    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }

}
