//
//  LunchesApp.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

@main
struct LunchesApp: App {
    init() {
        #if DEBUG
        print("Запущен в DEBUG!")
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
