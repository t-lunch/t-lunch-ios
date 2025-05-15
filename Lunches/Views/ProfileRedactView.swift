//
//  ProfileRedactView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ProfileRedactView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProfileRedactViewModel

    var body: some View {
        NavigationStack {
            VStack {
                LunchTextField(prompt: "Ваше имя", text: $viewModel.name, title: "Имя")
                LunchTextField(prompt: "Ваша фамилия", text: $viewModel.surname, title: "Фамилия")
                LunchTextField(prompt: "Ваш эмодзи-аватар", text: $viewModel.emojiIcon, title: "Эмодзи-аватар")
                LunchTextField(prompt: "Ваш ник в телеграм", text: $viewModel.tgContact, title: "ТГ-контакт")

                Spacer()

                Button("Сохранить") {
                    viewModel.saveButtonAction()
                    dismiss()
                }
                .buttonStyle(.lunchButton)
                .padding(.vertical, 10)
            }
            .onAppear {
                viewModel.fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Выйти") {
                        viewModel.logOutAction()
                    }
                }
            }
            .navigationTitle("Редактирование профиля")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileRedactView(viewModel: ViewModelFactory.previewContent.makeProfileRedactViewModel())
}
