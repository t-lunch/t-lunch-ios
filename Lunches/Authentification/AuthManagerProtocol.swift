//
//  AuthManagerProtocol.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import Foundation

protocol AuthManagerProtocol: ObservableObject {
    var accessToken: String? { get }
    var refreshToken: String? { get }
    var isAuthorized: Bool { get }

    func setUserId(to userId: IntId)
    func saveTokens(access: String, refresh: String)
    func clearTokens()

    func setIsAuthorized(to isAuthorized: Bool)
}
