//
//  HeroItemCollectionViewCell.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class HeroItemCollectionViewCell: UICollectionViewCell {

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

        // These properties are also exposed in Interface Builder.
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }

    // MARK: UICollectionReusableView
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: UIFocusEnvironment
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        /*
         Update the label's alpha value using the `UIFocusAnimationCoordinator`.
         This will ensure all animations run alongside each other when the focus
         changes.
         */
    }

}
