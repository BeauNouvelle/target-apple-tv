//
//  CategoryCollectionViewCell.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()
    let titleLabel = UILabel()

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
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 125
        contentView.clipsToBounds = true

        // These properties are also exposed in Interface Builder.
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        titleLabel.alpha = 0.0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = UIColor.init(white: 0.0, alpha: 0.3)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    // MARK: UICollectionReusableView
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.alpha = 0.0
    }

    // MARK: UIFocusEnvironment
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        /*
         Update the label's alpha value using the `UIFocusAnimationCoordinator`.
         This will ensure all animations run alongside each other when the focus
         changes.
         */
        coordinator.addCoordinatedAnimations({
            if self.isFocused {
                self.titleLabel.alpha = 1.0
            }
            else {
                self.titleLabel.alpha = 0.0
            }
            }, completion: nil)
    }

}
