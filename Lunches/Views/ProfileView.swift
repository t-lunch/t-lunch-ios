//
//  ProfileView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    var authManager: AuthManager
    var networkManager: LunchNetworkManagerProtocol
    
    init(authManager: AuthManager, networkManager: LunchNetworkManagerProtocol) {
        self.authManager = authManager
        self.networkManager = networkManager
        _viewModel = StateObject(wrappedValue: ProfileViewModel(authManager: authManager, networkManager: networkManager))
    }
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 0) {
                if viewModel.emojiIcon != nil {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 128))
                            .foregroundStyle(.tYellow.opacity(0.5))
                            .padding()
                        Text(viewModel.emojiIcon!)
                            .font(.system(size: 90))
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 128))
                        .foregroundStyle(.gray)
                        .padding()
                }
                Text("\(viewModel.name) \(viewModel.surname)")
                    .font(.system(size: 20))
                    .bold()
                
                if let tg = viewModel.tgContact {
                    HStack {
                        TelegramIcon()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.blue)
                        Text(tg)
                        
                        Spacer()
                    }
                    .padding()
                }
                
                Spacer()
            }
            .onAppear {
                viewModel.fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Редактировать") {
                        ProfileRedactView(authManager: authManager,
                                          networkManager: networkManager)
                    }
                }
            }
            .navigationTitle("Профиль")
        }
    }
}

#Preview {
    ProfileView(authManager: AuthManager(), networkManager: FakeLunchNetworkManager(authManager: AuthManager()))
}
