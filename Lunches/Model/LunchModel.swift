//
//  LunchModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import Foundation

struct Lunch: Identifiable {
    let id = UUID()
    
    let creator: User.ID
    var time: Date
    var place: Place
    var notes: String?
    var participants: [User.ID] = []
}

extension Lunch {
    static let example = Lunch(
        creator: MainUser.shared.id,
        time: Date(timeIntervalSince1970: 3600 * 12),
        place: .restaurant("СВОе место"),
        notes: "Some notes",
        participants: [MainUser.shared.id]
    )
}

enum Place {
    case restaurant(String)
    case kitchen
    
    func title() -> String{
        switch self {
        case .restaurant(let str):
            return str
        case .kitchen:
            return "Кухня"
        }
    }
}

let mockLunches: [Lunch] = Array(repeating: Lunch.example, count: 4)
