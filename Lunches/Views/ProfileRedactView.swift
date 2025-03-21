//
//  ProfileRedactView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ProfileRedactView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ProfileRedactViewModel()
    
    var body: some View {
        NavigationStack() {
            VStack() {
                LunchTextField(prompt: "Ваше имя", text: $vm.name, title: "Имя")
                LunchTextField(prompt: "Ваша фамилия", text: $vm.surname, title: "Фамилия")
                LunchTextField(prompt: "Ваш эмодзи-аватар", text: $vm.emojiIcon, title: "Эмодзи-аватар")
                LunchTextField(prompt: "Ваш ник в телеграм", text: $vm.tgContact, title: "ТГ-контакт")
                
                Spacer()
                
                Button("Сохранить") {
                    vm.saveButtonAction()
                    dismiss()
                }
                .buttonStyle(.lunchButton)
                .padding(.vertical, 10)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Выйти") {
                        if vm.logOutAction() {
                            contentViewModel.isLoggedIn = false
                        }
                    }
                }
            }
            .navigationTitle("Редактирование профиля")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileRedactView()
}
