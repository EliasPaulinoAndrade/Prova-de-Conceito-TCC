//
//  EventViewModelling.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

protocol EventViewModelling {
    var title: String { get }
    var author: String { get }
    var imageData: Data { get }
}
