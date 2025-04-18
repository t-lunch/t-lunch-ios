//
//  Place.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import Foundation

enum Place {
    case restaurant(String)
    case kitchen

    func title() -> String {
        switch self {
        case let .restaurant(str):
            return str
        case .kitchen:
            return "Кухня"
        }
    }
}
