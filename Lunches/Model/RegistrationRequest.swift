//
//  RegistrationRequest.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

struct RegistrationRequest: Codable, Equatable {
    let name: String
    let surname: String
    let tg: String
    let office: String
    let emoji: String
    let email: String
    let password: String
}
