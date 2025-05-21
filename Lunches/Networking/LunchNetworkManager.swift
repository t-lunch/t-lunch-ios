//
//  LunchNetworkManager.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation
import Logging
import SwiftUI

private let logger = Logger(label: "com.lunches.network")

struct LunchNetworkManager: LunchNetworkManagerProtocol {
    private let service: APIService
    private let authManager: any AuthManagerProtocol

    init(service: APIService, authManager: any AuthManagerProtocol) {
        self.service = service
        self.authManager = authManager
    }

    func registration(request: RegistrationRequest, completion: @escaping (Result<User, APIError>) -> Void) {
        guard let urlRequest = LunchEndpoint.registration(request: request).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for registration")))
            return
        }

        service.makeRequest(with: urlRequest, respModel: User.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for registration.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            self.authManager.setUserId(to: response.userId)
            login(request: LoginRequest(email: request.email, password: request.password)) { loginresponse in
                switch loginresponse {
                case .success:
                    completion(.success(response))
                case let .failure(failure):
                    completion(.failure(failure))
                }
            }
        }
    }

    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        guard let urlRequest = LunchEndpoint.login(request: request).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for login")))
            return
        }

        service.makeRequest(with: urlRequest, respModel: LoginResponse.self) { response, error in
            if let error = error {
                logger.error("Login request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for login.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            self.authManager.saveTokens(access: response.accessToken, refresh: response.refreshToken)
            self.authManager.setUserId(to: response.userId)
            completion(.success(response))
        }
    }

    func refresh(token: String, completion: @escaping (Result<RefreshResponse, APIError>) -> Void) {
        guard let urlRequest = LunchEndpoint.refresh(token: token).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for refresh")))
            return
        }

        service.makeRequest(with: urlRequest, respModel: RefreshResponse.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for refresh.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            self.authManager.saveTokens(access: response.accessToken, refresh: token)
            completion(.success(response))
        }
    }

    func getProfile(userId: IntId, completion: @escaping (Result<User, APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.getProfile(userId: userId).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for getProfile")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: User.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for getProfile.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response))
        }
    }

    func changeProfile(user: User, completion: @escaping (Result<User, APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.changeProfile(user: user).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for changeProfile")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: User.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for changeProfile.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response))
        }
    }

    func getLunches(userId: IntId, offset: Int32, limit: Int32, completion: @escaping (Result<[Lunch], APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.getLunches(userId: userId, offset: offset, limit: limit).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for getLunches")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: getLunchesResponse.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for getLunches.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response.lunches))
        }
    }

    func createLunch(request: CreateLunchRequest, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.createLunch(request: request).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for createLunch")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for createLunch.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response))
        }
    }

    func joinLunch(lunchId: IntId, userId: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.joinLunch(lunchId: lunchId, userId: userId).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for joinLunch")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for joinLunch.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response))
        }
    }

    func leaveLunch(lunchId: IntId, userId: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.leaveLunch(lunchId: lunchId, userId: userId).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for leaveLunch")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for leaveLunch.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response))
        }
    }

    func getDetailLunch(lunchId: IntId, completion: @escaping (Result<LunchResponse, APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.getDetailLunch(lunchId: lunchId).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for getDetailLunch")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: LunchResponse.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for getDetailLunch.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response))
        }
    }

    func getLunchHistory(userId: IntId, completion: @escaping (Result<[LunchFeedback], APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.getLunchHistory(userId: userId).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for getLunchHistory")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: LunchHistoryResponse.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for getLunchHistory.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response.lunches))
        }
    }

    func rateLunch(userId: IntId, lunchId: IntId, isLiked: Bool, completion: @escaping (Result<LunchFeedback, APIError>) -> Void) {
        guard var urlRequest = LunchEndpoint.rateLunch(userId: userId, lunchId: lunchId, isLiked: isLiked).request else {
            completion(.failure(.invalidResponse("Invalid URLRequest for rateLunch")))
            return
        }
        if let token = authManager.accessToken {
            urlRequest.authorize(with: token)
        }

        service.makeRequest(with: urlRequest, respModel: LunchFeedback.self) { response, error in
            if let error = error {
                logger.error("Network request failed: \(error.localizedDescription)")
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }
            guard let response = response else {
                logger.error("No data received for rateLunch.")
                completion(.failure(.invalidResponse("No data received")))
                return
            }
            completion(.success(response))
        }
    }
}
