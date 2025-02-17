//
//  ProfileView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 0) {
                if vm.emojiIcon != nil {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 128))
                            .foregroundStyle(.tYellow.opacity(0.5))
                            .padding()
                        Text(vm.emojiIcon!)
                            .font(.system(size: 90))
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 128))
                        .foregroundStyle(.gray)
                        .padding()
                }
                Text("\(vm.name) \(vm.surname)")
                    .font(.system(size: 20))
                    .bold()
                
                if let tg = vm.tgContact {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Редактировать") {
                        ProfileRedactView()
                    }
                }
            }
            .navigationTitle("Профиль")
        }
    }
}

#Preview {
    ProfileView()
}
