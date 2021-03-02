//
//  HomeViewable.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

protocol HomeViewable: AnyObject {
    func formatWith(lists: [CardListViewModel])
}
