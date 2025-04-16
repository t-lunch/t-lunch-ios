//
//  Lunch.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

// MARK: - Lunch
struct Lunch: Codable, Equatable {
    let id: Int64
    let name: String
    let surname: String
    let place: String
    let time: Date
    let numberOfParticipants: Int64
    let description: String?
    let users: [User]
}

extension Lunch {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case place
        case time
        case numberOfParticipants = "number_of_participants"
        case description
        case users
    }
}

// MARK: - LunchFeedback
struct LunchFeedback: Codable, Equatable {
    let lunch: Lunch
    let isLiked: Bool
}

extension LunchFeedback {
    enum CodingKeys: String, CodingKey {
        case lunch
        case isLiked = "is_liked"
    }
}

// MARK: - LunchRequest
struct LunchRequest: Codable, Equatable {
    let userId: Int64
    let offset: Int32
    let limit: Int32
}

extension LunchRequest {
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case offset
        case limit
    }
}

// MARK: - GetLunchesResponse
struct GetLunchesResponse: Codable, Equatable {
    let lunches: [Lunch]
    let lunchId: Int64?
}

extension GetLunchesResponse {
    enum CodingKeys: String, CodingKey {
        case lunches
        case lunchId = "lunch_id"
    }
}

// MARK: - CreateLunchRequest
struct CreateLunchRequest: Codable, Equatable {
    let userId: Int64
    let place: String
    let time: Date
    let description: String
}

extension CreateLunchRequest {
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case place
        case time
        case description
    }
}

// MARK: - LunchResponse
struct LunchResponse: Codable, Equatable {
    let lunch: Lunch
}

// MARK: - ActionLunchRequest
struct ActionLunchRequest: Codable, Equatable {
    let lunchId: Int64
    let userId: Int64
}

extension ActionLunchRequest {
    enum CodingKeys: String, CodingKey {
        case lunchId = "lunch_id"
        case userId = "user_id"
    }
}

// MARK: - DetailLunchRequest
struct DetailLunchRequest: Codable, Equatable {
    let lunchId: Int64
}

extension DetailLunchRequest {
    enum CodingKeys: String, CodingKey {
        case lunchId = "lunch_id"
    }
}

// MARK: - LunchHistoryResponse
struct LunchHistoryResponse: Codable, Equatable {
    let lunches: [LunchFeedback]
}

// MARK: - RateLunchRequest
struct RateLunchRequest: Codable, Equatable {
    let userId: Int64
    let lunchId: Int64
    let isLiked: Bool
}

extension RateLunchRequest {
    enum CodingKeys: String, CodingKey {
        case lunchId = "lunch_id"
        case userId = "user_id"
        case isLiked = "is_liked"
    }
}
