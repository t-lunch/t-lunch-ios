//
//  User.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

struct User: Codable, Equatable {
    let userId: IntId
    let name: String
    let surname: String
    let tg: String
    let office: String
    let emoji: String
}

extension User {
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case surname
        case tg
        case office
        case emoji
    }
}

struct UserRequest: Codable, Equatable {
    let userId: IntId
}
