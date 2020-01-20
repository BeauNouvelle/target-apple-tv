//
//  String+Match.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

public extension String {
    func match(pattern: String) -> NSTextCheckingResult? {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let matches = regex.matches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.count))
            return matches.first
        } catch {
            return nil
        }
    }

    func match(patterns: [String]) -> NSTextCheckingResult? {
        for pattern in patterns {
            if let match = self.match(pattern: pattern) {
                return match
            }
        }
        return nil
    }

    // return first match group's value
    func extractValue(pattern: String) -> String? {
        if let match = self.match(pattern: pattern), match.numberOfRanges > 1 {
            return (self as NSString).substring(with: match.range(at: 1))
        }
        return nil
    }

    func extractValue(patterns: [String]) -> String? {
        for pattern in patterns {
            if let value = self.extractValue(pattern: pattern) {
                return value
            }
        }
        return nil
    }
}
