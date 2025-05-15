//
//  FakeLunchNetworkManager.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

final class FakeLunchNetworkManager: LunchNetworkManagerProtocol {
    private let authManager: any AuthManagerProtocol

    init(authManager: any AuthManagerProtocol) {
        self.authManager = authManager
    }

    func registration(request: RegistrationRequest, completion: @escaping (Result<User, APIError>) -> Void) {
        let user = User(userId: 1, name: request.name, surname: request.surname, tg: request.tg, office: request.office, emoji: request.emoji)
        authManager.setIsAuthorized(to: true)
        completion(.success(user))
    }

    func login(request _: LoginRequest, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        let response = LoginResponse(accessToken: "fakeAccessToken", refreshToken: "fakeRefreshToken")
        authManager.setIsAuthorized(to: true)
        completion(.success(response))
    }

    func refresh(token _: String, completion: @escaping (Result<RefreshResponse, APIError>) -> Void) {
        let response = RefreshResponse(accessToken: "newFakeAccessToken")
        authManager.setIsAuthorized(to: true)
        completion(.success(response))
    }

    func getProfile(userId: IntId, completion: @escaping (Result<User, APIError>) -> Void) {
        let user = User(userId: userId, name: "Иван", surname: "Иванов", tg: "@ivan", office: "A101", emoji: "😎")
        completion(.success(user))
    }

    func changeProfile(user: User, completion: @escaping (Result<User, APIError>) -> Void) {
        completion(.success(user))
    }

    func getLunches(userId _: IntId, offset _: Int32, limit _: Int32, completion: @escaping (Result<[Lunch], APIError>) -> Void) {
        let lunch = Lunch(id: 1, name: "Анна", surname: "Петрова", place: "Кафе 'Еда'", time: Date(), numberOfParticipants: 3, description: "Обед всей командой", users: [])
        completion(.success([lunch]))
    }

    func createLunch(request: CreateLunchRequest, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        let lunch = Lunch(id: 1, name: "Анна", surname: "Петрова", place: request.place, time: Date(), numberOfParticipants: 1, description: request.description, users: [])
        completion(.success(LunchResponse(lunch: lunch)))
    }

    func joinLunch(lunchId: IntId, userId _: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 4, description: "Обед", users: [])
        completion(.success(LunchResponse(lunch: lunch)))
    }

    func leaveLunch(lunchId: IntId, userId _: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 2, description: "Обед", users: [])
        completion(.success(LunchResponse(lunch: lunch)))
    }

    func getDetailLunch(lunchId: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 3, description: "Детали обеда", users: [])
        completion(.success(LunchResponse(lunch: lunch)))
    }

    func getLunchHistory(userId _: IntId, completion: @escaping (Result<[Lunch], APIError>) -> Void) {
        let lunch = Lunch(id: 42, name: "Игорь", surname: "К", place: "Пельменная", time: Date(), numberOfParticipants: 5, description: "История обедов", users: [])
        completion(.success([lunch]))
    }

    func rateLunch(userId _: IntId, lunchId: IntId, isLiked: Bool, completion: @escaping (Result<LunchFeedback, APIError>) -> Void) {
        let lunch = Lunch(id: lunchId, name: "Анна", surname: "Петрова", place: "Кафе", time: Date(), numberOfParticipants: 3, description: nil, users: [])
        let feedback = LunchFeedback(lunch: lunch, isLiked: isLiked)
        completion(.success(feedback))
    }
}
