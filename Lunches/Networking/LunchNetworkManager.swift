//
//  LunchNetworkManager.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//


import Foundation
import SwiftUI

struct LunchNetworkManager: LunchNetworkManagerProtocol {
    private let service: APIService
    let authManager: AuthManager

    init(service: APIService, authManager: AuthManager) {
        self.service = service
        self.authManager = authManager
    }

    func registration(request: RegistrationRequest, completion: @escaping (User?) -> Void) {
        guard let urlRequest = LunchEndpoint.registration(request: request).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: User.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }

    func login(request: LoginRequest, completion: @escaping (LoginResponse?) -> Void) {
        guard let urlRequest = LunchEndpoint.login(request: request).request else {
            completion(nil)
            return
        }

        service.makeRequest(with: urlRequest, respModel: LoginResponse.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            if let response = response {
                self.authManager.saveTokens(access: response.accessToken, refresh: response.refreshToken)
            }
            completion(response)
        }
    }

    func refresh(token: String, completion: @escaping (RefreshResponse?) -> Void) {
        guard let urlRequest = LunchEndpoint.refresh(token: token).request else {
            completion(nil)
            return
        }

        service.makeRequest(with: urlRequest, respModel: RefreshResponse.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            if let response = response {
                self.authManager.saveTokens(access: response.accessToken, refresh: token)
            }
            completion(response)
        }
    }

    func getProfile(userId: Int64, completion: @escaping (User?) -> Void) {
        guard let urlRequest = LunchEndpoint.getProfile(userId: userId).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: User.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }

    func changeProfile(user: User, completion: @escaping (User?) -> Void) {
        guard let urlRequest = LunchEndpoint.changeProfile(user: user).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: User.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }

    func getLunches(userId: Int64, offset: Int32, limit: Int32, completion: @escaping ([Lunch]) -> Void) {
        guard let urlRequest = LunchEndpoint.getLunches(userId: userId, offset: offset, limit: limit).request else {
            completion([])
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: [Lunch].self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            completion(response ?? [])
        }
    }

    func createLunch(request: CreateLunchRequest, completion: @escaping (LunchResponse?) -> Void) {
        guard let urlRequest = LunchEndpoint.createLunch(request: request).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }

    func joinLunch(lunchId: Int64, userId: Int64, completion: @escaping (LunchResponse?) -> Void) {
        guard let urlRequest = LunchEndpoint.joinLunch(lunchId: lunchId, userId: userId).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }

    func leaveLunch(lunchId: Int64, userId: Int64, completion: @escaping (LunchResponse?) -> Void) {
        guard let urlRequest = LunchEndpoint.leaveLunch(lunchId: lunchId, userId: userId).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }

    func getDetailLunch(lunchId: Int64, completion: @escaping (LunchResponse?) -> Void) {
        guard let urlRequest = LunchEndpoint.getDetailLunch(lunchId: lunchId).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }

    func getLunchHistory(userId: Int64, completion: @escaping ([Lunch]) -> Void) {
        guard let urlRequest = LunchEndpoint.getLunchHistory(userId: userId).request else {
            completion([])
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: [Lunch].self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            completion(response ?? [])
        }
    }

    func rateLunch(userId: Int64, lunchId: Int64, isLiked: Bool, completion: @escaping (LunchFeedback?) -> Void) {
        guard let urlRequest = LunchEndpoint.rateLunch(userId: userId, lunchId: lunchId, isLiked: isLiked).request else {
            completion(nil)
            return
        }
        
        service.makeRequest(with: urlRequest, respModel: LunchFeedback.self) { response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            completion(response)
        }
    }
}
