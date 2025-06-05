//
//  Lunch.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

// MARK: - Lunch

struct Lunch: Codable, Identifiable, Equatable {
    let id: IntId
    let name: String
    let surname: String
    let place: String
    let time: Date
    let numberOfParticipants: IntId
    let description: String?
    let usersId: [IntId]
}

extension Lunch {
    static let example = Lunch(id: "0",
                               name: "Name",
                               surname: "Surname",
                               place: "Place",
                               time: Date(),
                               numberOfParticipants: "12",
                               description: "descriptiondescriptiondescriptiondescriptiondescriptiondescription",
                               usersId: [
                                   "1",
                               ])
}

// MARK: - LunchFeedback

struct LunchFeedback: Codable, Equatable {
    let lunch: Lunch
    var isLiked: Bool
}

// MARK: - LunchRequest

struct LunchRequest: Codable, Equatable {
    let userId: IntId
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
    let lunchId: IntId?
}

extension GetLunchesResponse {
    enum CodingKeys: String, CodingKey {
        case lunches
        case lunchId = "lunch_id"
    }
}

// MARK: - CreateLunchRequest

struct CreateLunchRequest: Codable, Equatable {
    let userId: IntId
    let place: String
    let time: Date
    let description: String
}

// MARK: - LunchResponse

struct LunchResponse: Codable, Equatable {
    let lunch: Lunch
}

// MARK: - ActionLunchRequest

struct ActionLunchRequest: Codable, Equatable {
    let lunchId: IntId
    let userId: IntId
}

extension ActionLunchRequest {
    enum CodingKeys: String, CodingKey {
        case lunchId = "lunch_id"
        case userId = "user_id"
    }
}

// MARK: - DetailLunchRequest

struct DetailLunchRequest: Codable, Equatable {
    let lunchId: IntId
}

struct getLunchesResponse: Codable {
    let lunches: [Lunch]
    let lunchId: IntId?
}

// MARK: - LunchHistoryResponse

struct LunchHistoryResponse: Codable, Equatable {
    let lunches: [LunchFeedback]
}

// MARK: - RateLunchRequest

struct RateLunchRequest: Codable, Equatable {
    let userId: IntId
    let lunchId: IntId
    let isLiked: Bool
}
