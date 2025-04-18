//
//  AuthManager.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import Foundation
import SwiftUI

final class AuthManager: AuthManagerProtocol {
    @Published private(set) var isAuthorized: Bool = false
    @AppStorage("userId") private(set) var userId: Int = -1

    private let userDefaults = UserDefaults.standard
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"

    var accessToken: String? {
        userDefaults.string(forKey: accessTokenKey)
    }

    var refreshToken: String? {
        userDefaults.string(forKey: refreshTokenKey)
    }

    init() {
        isAuthorized = accessToken != nil
    }

    func saveTokens(access: String, refresh: String) {
        userDefaults.set(access, forKey: accessTokenKey)
        userDefaults.set(refresh, forKey: refreshTokenKey)
        isAuthorized = true
    }

    func clearTokens() {
        userDefaults.removeObject(forKey: accessTokenKey)
        userDefaults.removeObject(forKey: refreshTokenKey)
        isAuthorized = false
    }

    func setIsAuthorized(to isAuthorized: Bool) {
        self.isAuthorized = isAuthorized
    }
}
