//
//  Settable.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

protocol Settable { }

extension Settable {
    func set(setter: (Self) -> Self) -> Self {
        return setter(self)
    }
    
    func set<ValueType>(_ keypath: WritableKeyPath<Self, ValueType>, _ value: ValueType) -> Self {
        var selfReference = self
        selfReference[keyPath: keypath] = value
        return selfReference
    }
}

extension Settable where Self: AnyObject {
    func set(setter: (Self) -> Void) -> Self {
        setter(self)
        return self
    }
}

extension Array where Element: Settable {
    @discardableResult
    func set<ValueType>(_ keypath: WritableKeyPath<Element, ValueType>, _ value: ValueType) -> Self {
        map {
            $0.set(keypath, value)
        }
    }
}

extension NSObject: Settable { }
