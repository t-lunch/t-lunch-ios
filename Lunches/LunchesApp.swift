//
//  LunchesApp.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

@main
struct LunchesApp: App {
    var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView(appCoordinator: appCoordinator)
        }
    }
}
