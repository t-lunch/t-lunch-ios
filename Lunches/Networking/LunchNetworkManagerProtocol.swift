//
//  LunchNetworkManagerProtocol.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//


protocol LunchNetworkManagerProtocol {
    var token: String { get set }

    func registration(request: RegistrationRequest, completion: @escaping (User?) -> Void)
    func login(request: LoginRequest, completion: @escaping (LoginResponse?) -> Void)
    func refresh(token: String, completion: @escaping (RefreshResponse?) -> Void)

    func getProfile(userId: Int64, completion: @escaping (User?) -> Void)
    func changeProfile(user: User, completion: @escaping (User?) -> Void)

    func getLunches(userId: Int64, offset: Int32, limit: Int32, completion: @escaping ([Lunch]) -> Void)
    func createLunch(request: CreateLunchRequest, completion: @escaping (LunchResponse?) -> Void)

    func joinLunch(lunchId: Int64, userId: Int64, completion: @escaping (LunchResponse?) -> Void)
    func leaveLunch(lunchId: Int64, userId: Int64, completion: @escaping (LunchResponse?) -> Void)

    func getDetailLunch(lunchId: Int64, completion: @escaping (LunchResponse?) -> Void)
    func getLunchHistory(userId: Int64, completion: @escaping ([Lunch]) -> Void)

    func rateLunch(userId: Int64, lunchId: Int64, isLiked: Bool, completion: @escaping (LunchFeedback?) -> Void)
}