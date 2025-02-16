//
//  LunchModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import Foundation

struct Lunch {
    let creator: User.ID
    var time: Date
    var place: Place
    var notes: String?
    var participants: [User.ID] = []
    
#if DEBUG
    init() {
        creator = MainUser.shared.id
        time = Date().addingTimeInterval(3600)
        place = .kithcen
        notes = "Some notes"
        participants = [MainUser.shared.id]
    }
#endif
}

enum Place: String {
    case restaurant = ""
    case kithcen
}
