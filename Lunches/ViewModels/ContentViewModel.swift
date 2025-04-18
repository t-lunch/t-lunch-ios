//
//  ContentViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 17.04.2025.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @ObservedObject var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    var isAuthorized: Bool {
        authManager.isAuthorized
    }
}
