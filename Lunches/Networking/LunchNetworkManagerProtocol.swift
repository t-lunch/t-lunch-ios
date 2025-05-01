//
//  LunchNetworkManagerProtocol.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

protocol LunchNetworkManagerProtocol {
    func registration(request: RegistrationRequest, completion: @escaping (Result<User, APIError>) -> Void)
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, APIError>) -> Void)
    func refresh(token: String, completion: @escaping (Result<RefreshResponse, APIError>) -> Void)

    func getProfile(userId: Int64, completion: @escaping (Result<User, APIError>) -> Void)
    func changeProfile(user: User, completion: @escaping (Result<User, APIError>) -> Void)

    func getLunches(userId: Int64, offset: Int32, limit: Int32, completion: @escaping (Result<[Lunch], APIError>) -> Void)
    func createLunch(request: CreateLunchRequest, completion: @escaping (Result<LunchResponse, APIError>) -> Void)

    func joinLunch(lunchId: Int64, userId: Int64, completion: @escaping (Result<LunchResponse, APIError>) -> Void)
    func leaveLunch(lunchId: Int64, userId: Int64, completion: @escaping (Result<LunchResponse, APIError>) -> Void)

    func getDetailLunch(lunchId: Int64, completion: @escaping (Result<LunchResponse, APIError>) -> Void)
    func getLunchHistory(userId: Int64, completion: @escaping (Result<[Lunch], APIError>) -> Void)

    func rateLunch(userId: Int64, lunchId: Int64, isLiked: Bool, completion: @escaping (Result<LunchFeedback, APIError>) -> Void)
}
