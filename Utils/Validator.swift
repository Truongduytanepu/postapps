//
//  Validator.swift
//  Ex1
//
//  Created by Trương Duy Tân on 09/06/2023.
//

import Foundation

protocol Validator {
    func isValid() -> Bool
}

private extension String {
    func isMatching(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.anchored,
                                    range: NSRange(location: 0, length: self.count))
            return res.count > 0
        } catch {
            return false
        }
    }
}


