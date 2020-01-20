//
//  UICollectionView+Dequeue.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    public func dequeue<T: UICollectionViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error: cell with id:\(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }

    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(reusableClass: T.Type, ofKind: String, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: ofKind,
                                                          withReuseIdentifier: reusableClass.reuseIdentifier,
                                                          for: indexPath) as? T else {
            fatalError("Error: view with id:\(reusableClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return view
    }

}
