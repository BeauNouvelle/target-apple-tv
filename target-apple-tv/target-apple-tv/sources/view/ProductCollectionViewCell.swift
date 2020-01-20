//
//  ProductCollectionViewCell.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class ProductCollectionViewCell: UICollectionViewCell {

    let tagLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let imageView = UIImageView()
    let ratingLabel = UILabel()

    private let textBackgroundView = UIView()

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

        imageView.contentMode = .scaleAspectFill
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        imageView.overlayContentView.addSubview(textBackgroundView)

        textBackgroundView.addSubview(tagLabel)
        textBackgroundView.addSubview(ratingLabel)
        textBackgroundView.addSubview(titleLabel)
        textBackgroundView.addSubview(priceLabel)

        textBackgroundView.alpha = 0.0
        textBackgroundView.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        textBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tagLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        tagLabel.setContentHuggingPriority(.required, for: .vertical)
        tagLabel.font = .preferredFont(for: .footnote, weight: .semibold)
        tagLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
        }

        priceLabel.textAlignment = .center
        priceLabel.textColor = .black
        priceLabel.font = .preferredFont(forTextStyle: .headline)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(ratingLabel.snp.top).offset(8)
        }

        ratingLabel.textColor = #colorLiteral(red: 0.9764265418, green: 0.7961158156, blue: 0.2235357463, alpha: 1)
        ratingLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }

    }

    // MARK: UICollectionReusableView
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        textBackgroundView.alpha = 0.0
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
                self.textBackgroundView.alpha = 1.0

            }
            else {
                self.textBackgroundView.alpha = 0.0
            }
            }, completion: nil)
    }

}
