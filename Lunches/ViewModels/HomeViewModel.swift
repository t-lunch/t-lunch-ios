//
//  HomeViewModel.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    var networkManager: LunchNetworkManagerProtocol
    var authManager: AuthManager
    var globalLogger: GlobalLogger

    @Published var searchText: String

    @Published var lunches: [Lunch]
    @Published var participants: [User] = []
    @Published var selectedLunch: Lunch?

    @Published var isAddingSheetPresented: Bool
    @Published var sheetTimeSelection: String
    @Published var sheetPlaceSelection: String
    @Published var sheetPlaceName: String
    @Published var sheetNotes: String

    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol, globalLogger: GlobalLogger) {
        self.networkManager = networkManager
        self.authManager = authManager
        self.globalLogger = globalLogger

        lunches = []
        searchText = ""
        selectedLunch = nil
        isAddingSheetPresented = false
        sheetTimeSelection = "11:00"
        sheetPlaceSelection = "Кухня"
        sheetPlaceName = ""
        sheetNotes = ""
    }

    func fetchData() {
        networkManager.getLunches(userId: IntId(authManager.userId), offset: 0, limit: 100) { result in
            switch result {
            case let .success(success):
                DispatchQueue.main.async {
                    self.lunches = success
                }
            case let .failure(failure):
                if let description = failure.errorDescription {
                    self.globalLogger.logError(description)
                } else {
                    self.globalLogger.logError("Error while fetching data")
                }
            }
        }
    }

    func fetchParticipants(for lunch: Lunch) {
        participants = []
        for userId in lunch.usersId {
            networkManager.getProfile(userId: userId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(user):
                        self?.participants.append(user)
                    case let .failure(failure):
                        if let description = failure.errorDescription {
                            self?.globalLogger.logError(description)
                        } else {
                            self?.globalLogger.logError("Error while fetching users")
                        }
                    }
                }
            }
        }
    }

    func verifyAttendance(to lunch: Lunch) -> Bool {
        return lunch.usersId.contains(authManager.userId)
    }

    func addButtonAction() {
        isAddingSheetPresented = true
    }

    func joinLunch(_ lunch: Lunch) {
        networkManager.joinLunch(
            lunchId: lunch.id,
            userId: IntId(authManager.userId)
        ) { response in
            switch response {
            case .success:
                break
            case let .failure(failure):
                if let description = failure.errorDescription {
                    self.globalLogger.logError(description)
                } else {
                    self.globalLogger.logError("Error at joining lunch")
                }
            }
        }
        fetchData()
    }

    func saveNewLunch() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current

        if let date = formatter.date(from: sheetTimeSelection) {
            networkManager.createLunch(request: CreateLunchRequest(userId: IntId(authManager.userId), place: sheetPlaceName == "" ? "Кухня" : sheetPlaceName, time: date, description: sheetNotes)) { response in
                switch response {
                case let .success(success):
                    self.globalLogger.logInfo("Lunch \(success.lunch.id) has been created")
                case let .failure(failure):
                    if let description = failure.errorDescription {
                        self.globalLogger.logError(description)
                    } else {
                        self.globalLogger.logError("Error while creating lunch")
                    }
                }
            }
        } else {
            globalLogger.logError("Time parsing error")
        }
        fetchData()
    }
}
