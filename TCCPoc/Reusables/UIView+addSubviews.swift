//
//  UIView+addSubviews.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import UIKit

extension UIView {
    func addSubviews(_ subsviews: UIView...) {
        subsviews.forEach {
            addSubview($0)
        }
    }
}
