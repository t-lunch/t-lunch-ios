//
//  Login.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

struct LoginRequest: Codable, Equatable {
    let email: String
    let password: String
}

struct LoginResponse: Codable, Equatable {
    let accessToken: String
    let refreshToken: String
}

extension LoginResponse {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
