//
//  Refresh.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

struct RefreshRequest: Codable, Equatable {
    let refreshToken: String
}

struct RefreshResponse: Codable, Equatable {
    let accessToken: String
}

extension RefreshRequest {
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

extension RefreshResponse {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
