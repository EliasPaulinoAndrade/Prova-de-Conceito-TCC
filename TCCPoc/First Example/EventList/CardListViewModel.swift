//
//  CardListViewModel.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

class CardListViewModel: CardListViewModelling, Hashable {
    typealias ViewModelType = EventViewModel
    weak var viewable: EventListViewable?
    private let id: String
    private let events: [EventViewModel]
    var title: String
    
    var hashValue: Int {
        ObjectIdentifier(self).hashValue
    }
    
    init(id: String, title: String, events: [EventViewModel]) {
        self.events = events
        self.id = id
        self.title = title
    }
    
    func getEvents() {
        viewable?.formatWith(events: events)
    }
    
    static func == (lhs: CardListViewModel, rhs: CardListViewModel) -> Bool {
        lhs.id == rhs.id && lhs.events == rhs.events
    }
}
