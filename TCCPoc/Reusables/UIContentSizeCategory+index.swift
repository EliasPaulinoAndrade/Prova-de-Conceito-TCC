//
//  UIContentSizeCategory+index.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import UIKit

extension UIContentSizeCategory {
    var index: Int {
        switch self {
        case .extraSmall:
            return -2
        case .small:
            return -1
        case .medium, .unspecified:
            return 0
        case .large:
            return 1
        case .extraLarge:
            return 2
        case .extraExtraLarge:
            return 3
        case .extraExtraExtraLarge:
            return 4
        case .accessibilityMedium:
            return 5
        case .accessibilityLarge:
            return 6
        case .accessibilityExtraLarge:
            return 7
        case .accessibilityExtraExtraLarge:
            return 8
        case .accessibilityExtraExtraExtraLarge:
            return 9
        default:
            return 0
        }
    }
}
