//
//  AppCoordinator.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import Foundation

final class AppCoordinator: ObservableObject {
    let authManager: AuthManager
    let networkManager: LunchNetworkManagerProtocol

    init() {
        authManager = AuthManager()
//        networkManager = LunchNetworkManager(service: APIService(urlSession: URLSession.shared), authManager: authManager)
        networkManager = FakeLunchNetworkManager(authManager: authManager
        )
    }
}
