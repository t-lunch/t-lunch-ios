//
//  SignUpView.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 90)
                VStack {
                    Text("Регистрация")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    LunchTextField(prompt: "Ваш e-mail", text: $viewModel.email, title: "Логин")
                    LunchTextField(text: $viewModel.password, title: "Пароль", isSecured: $viewModel.isPasswordFieldSecured)
                        .padding(.bottom, 20)
                    LunchTextField(prompt: "Ваше имя", text: $viewModel.name, title: "Имя")
                    LunchTextField(prompt: "Ваша фамилия", text: $viewModel.surname, title: "Фамилия")
                    LunchTextField(prompt: "Ваш ник в телеграм", text: $viewModel.tgContact, title: "ТГ-контакт")
                }

                Spacer()

                Button("Зарегистрироваться") {
                    viewModel.signInButtonAction()
                }
                .buttonStyle(.lunchButton)

                HStack {
                    Text("Уже зарегистрированы?")
                        .fontWeight(.light)
                    NavigationLink {
                        LoginView(viewModel: viewModel.makeLoginViewModel())
                    } label: {
                        Text("Войти")
                            .bold()
                            .underline()
                    }
                }
                .font(.footnote)
                .foregroundStyle(.primary)
                .padding(.top)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    SignUpView(viewModel: ViewModelFactory.previewContent.makeSignUpViewModel())
}
