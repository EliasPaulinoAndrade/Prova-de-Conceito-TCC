//
//  CardListViewable.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

protocol EventListViewable: AnyObject {
    func formatWith(viewModel: CardListViewModelling)
    func formatWith(events: [EventViewModel])
}
