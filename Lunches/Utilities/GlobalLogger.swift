//
//  GlobalLogger.swift
//  Lunches
//
//  Created by Андрей Степанов on 28.04.2025.
//


import SwiftUI
import Combine
import Logging

final class GlobalLogger: ObservableObject {
    @Published var globalError: String?

    private let logger: Logger

    init(label: String) {
        self.logger = Logger(label: label)
    }

    func logError(_ message: String) {
        logger.error("\(message)")
        DispatchQueue.main.async {
            self.globalError = message
        }
    }

    func logInfo(_ message: String) {
        logger.info("\(message)")
    }

    func clearError() {
        globalError = nil
    }
}
