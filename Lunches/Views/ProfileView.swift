//
//  ProfileView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        NavigationStack {
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
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("Ошибка"), message: Text(errorMessage), dismissButton: .default(Text("Ок")))
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Редактировать") {
                        ProfileRedactView(viewModel: viewModel.makeProfileRedactView())
                    }
                }
            })
            .navigationTitle("Профиль")
        }
    }
}

#Preview {
    ProfileView(viewModel: ViewModelFactory.previewContent.makeProfileViewModel())
}
