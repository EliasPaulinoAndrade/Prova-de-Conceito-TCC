//
//  ViewCodable.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

protocol ViewCodable {
    func buildHierarchy()
    func setupConstraints()
    func applyAddtionalChanges()
    func setupAccessibility()
}

extension ViewCodable {
    func buildHierarchy() { }
    func setupConstraints() { }
    func applyAddtionalChanges() { }
    func setupAccessibility() { }
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAddtionalChanges()
        setupAccessibility()
    }
}

