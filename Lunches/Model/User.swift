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

struct UserRequest: Codable, Equatable {
    let userId: IntId
}
