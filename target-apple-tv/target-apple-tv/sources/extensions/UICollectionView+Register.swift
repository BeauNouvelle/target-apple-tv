//
//  UICollectionView+Register.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    public func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func register<T: UICollectionReusableView>(reusableClass: T.Type, forSupplementaryViewOfKind kind: String) {
        register(reusableClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: reusableClass.reuseIdentifier)
    }

}
