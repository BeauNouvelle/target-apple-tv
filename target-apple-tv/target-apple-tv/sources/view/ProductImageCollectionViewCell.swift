//
//  ProductImageCollectionViewCell.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class ProductImageCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    @available(tvOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(imageView)
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
