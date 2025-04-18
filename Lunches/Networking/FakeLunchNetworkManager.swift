//
//  FakeLunchNetworkManager.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

final class FakeLunchNetworkManager: LunchNetworkManagerProtocol {
    let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func registration(request: RegistrationRequest, completion: @escaping (User?) -> Void) {
        let user = User(userId: 1, name: request.name, surname: request.surname, tg: request.tg, office: request.office, emoji: request.emoji)
        completion(user)
    }

    func login(request: LoginRequest, completion: @escaping (LoginResponse?) -> Void) {
        let response = LoginResponse(accessToken: "fakeAccessToken", refreshToken: "fakeRefreshToken")
        authManager.setIsAuthorized(to: true)
        completion(response)
    }

    func refresh(token: String, completion: @escaping (RefreshResponse?) -> Void) {
        let response = RefreshResponse(accessToken: "newFakeAccessToken")
        authManager.setIsAuthorized(to: true)
        completion(response)
    }

    func getProfile(userId: Int64, completion: @escaping (User?) -> Void) {
        let user = User(userId: userId, name: "Иван", surname: "Иванов", tg: "@ivan", office: "A101", emoji: "😎")
        completion(user)
    }

    func changeProfile(user: User, completion: @escaping (User?) -> Void) {
        completion(user)
    }

    func getLunches(userId: Int64, offset: Int32, limit: Int32, completion: @escaping ([Lunch]) -> Void) {
        let lunch = Lunch(id: 1, name: "Анна", surname: "Петрова", place: "Кафе 'Еда'", time: Date(), numberOfParticipants: 3, description: "Обед всей командой", users: [])
        completion([lunch])
    }

    func createLunch(request: CreateLunchRequest, completion: @escaping (LunchResponse?) -> Void) {
        let lunch = Lunch(id: 1, name: "Анна", surname: "Петрова", place: request.place, time: Date(), numberOfParticipants: 1, description: request.description, users: [])
        completion(LunchResponse(lunch: lunch))
    }

    func joinLunch(lunchId: Int64, userId: Int64, completion: @escaping (LunchResponse?) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 4, description: "Обед", users: [])
        completion(LunchResponse(lunch: lunch))
    }

    func leaveLunch(lunchId: Int64, userId: Int64, completion: @escaping (LunchResponse?) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 2, description: "Обед", users: [])
        completion(LunchResponse(lunch: lunch))
    }

    func getDetailLunch(lunchId: Int64, completion: @escaping (LunchResponse?) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 3, description: "Детали обеда", users: [])
        completion(LunchResponse(lunch: lunch))
    }

    func getLunchHistory(userId: Int64, completion: @escaping ([Lunch]) -> Void) {
        let lunch = Lunch(id: 42, name: "Игорь", surname: "К", place: "Пельменная", time: Date(), numberOfParticipants: 5, description: "История обедов", users: [])
        completion([lunch])
    }

    func rateLunch(userId: Int64, lunchId: Int64, isLiked: Bool, completion: @escaping (LunchFeedback?) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 3, description: nil, users: [])
        let feedback = LunchFeedback(lunch: lunch, isLiked: isLiked)
        completion(feedback)
    }
}
