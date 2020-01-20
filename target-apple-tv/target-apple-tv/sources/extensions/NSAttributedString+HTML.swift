//
//  NSAttributedString+HTML.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

extension NSAttributedString {

    public convenience init?(HTMLString html: String) throws {
        let options : [NSAttributedString.DocumentReadingOptionKey : Any] =
            [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
             NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]

        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            let error = NSError(domain: "Parse Error", code: 0, userInfo: ["badString": html])
            throw error
        }

        try? self.init(data: data, options: options, documentAttributes: nil)
    }

}

protocol NSAttributedStringConvertible {
    func toAttributedString() -> NSAttributedString
}

extension NSAttributedString: NSAttributedStringConvertible {
    func toAttributedString() -> NSAttributedString {
        return self
    }
}

extension String: NSAttributedStringConvertible {
    func toAttributedString() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}

func concatenate(_ first: NSAttributedStringConvertible, spacing: NSAttributedString, rest: NSAttributedStringConvertible...) -> NSAttributedString {
    return rest.reduce(NSMutableAttributedString(attributedString: first.toAttributedString())) { (acc: NSMutableAttributedString, elem: NSAttributedStringConvertible) -> NSMutableAttributedString in
        acc.append(spacing)
        acc.append(elem.toAttributedString())
        return acc
    }
}
