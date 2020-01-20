//
//  UILabel+Rating.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UILabel {

    func setRating(_ rating: Float, outOf total: Int) {
        let topLabelTag = 2233
        setContentCompressionResistancePriority(.required, for: .horizontal)

        guard rating > 0 else {
            text = nil
            (viewWithTag(topLabelTag) as? UILabel)?.removeFromSuperview()
            return
        }

        let ratingString = Array(repeating: "★", count: Int(ceil(rating))).joined(separator: " ")
        let emptyStarString = Array(repeating: "☆", count: total).joined(separator: " ")

        text = emptyStarString

        let topLabel: UILabel

        if let taggedView = viewWithTag(topLabelTag) as? UILabel {
            topLabel = taggedView
        } else {
            topLabel = UILabel()
            topLabel.tag = topLabelTag
            addSubview(topLabel)
        }

        topLabel.font = font
        topLabel.textColor = textColor
        topLabel.tintColor = tintColor
        topLabel.textAlignment = textAlignment
        topLabel.clipsToBounds = true
        topLabel.lineBreakMode = .byClipping
        topLabel.setContentHuggingPriority(.required, for: .horizontal)
        topLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        topLabel.text = ratingString

        let starPercentage = rating / Float(total)

        topLabel.snp.remakeConstraints { (remake) in
            remake.leading.top.bottom.equalToSuperview()
            remake.width.equalToSuperview().multipliedBy(starPercentage)
        }
    }

}
