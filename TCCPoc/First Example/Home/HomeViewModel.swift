//
//  HomeViewModel.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

class HomeViewModel: HomeViewModelling {
    weak var viewable: HomeViewable?
    private let lists: [CardListViewModel]
    
    init(lists: [CardListViewModel]) {
        self.lists = lists
    }
    
    func getLists() {
        viewable?.formatWith(lists: lists)
    }
}
