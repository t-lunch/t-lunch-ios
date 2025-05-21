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

    func getProfile(userId: IntId, completion: @escaping (Result<User, APIError>) -> Void)
    func changeProfile(user: User, completion: @escaping (Result<User, APIError>) -> Void)

    func getLunches(userId: IntId, offset: Int32, limit: Int32, completion: @escaping (Result<[Lunch], APIError>) -> Void)
    func createLunch(request: CreateLunchRequest, completion: @escaping (Result<LunchResponse, APIError>) -> Void)

    func joinLunch(lunchId: IntId, userId: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void)
    func leaveLunch(lunchId: IntId, userId: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void)

    func getDetailLunch(lunchId: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void)
    func getLunchHistory(userId: IntId, completion: @escaping (Result<[LunchFeedback], APIError>) -> Void)

    func rateLunch(userId: IntId, lunchId: IntId, isLiked: Bool, completion: @escaping (Result<LunchFeedback, APIError>) -> Void)
}
