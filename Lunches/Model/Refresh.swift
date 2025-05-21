//
//  Refresh.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

struct RefreshRequest: Codable, Equatable {
    let refreshToken: String
    let userId: IntId
}

struct RefreshResponse: Codable, Equatable {
    let accessToken: String
}
