//
//  EventViewModel.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import Foundation

struct EventViewModel: EventViewModelling, Hashable {
    let id: String
    let title: String
    let author: String
    let imageData: Data
    let date = Date()
    var formattedDate: String {
        let format = "EE dd MMM HH: mm"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date).uppercased()
    }
    var expandedFormatedDate: String {
        let customFormat = "EEEEddMMMMHHHHmm"
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: Locale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
