//
//  SignUpView.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @StateObject var vm = SignUpViewModel()
    
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
                    LunchTextField(prompt: "Ваш логин", text: $vm.login, title: "Логин")
                    LunchTextField(text: $vm.password, title: "Пароль", isSecured: $vm.isPasswordFieldSecured)
                        .padding(.bottom, 20)
                    LunchTextField(prompt: "Ваше имя", text: $vm.name, title: "Имя")
                    LunchTextField(prompt: "Ваша фамилия", text: $vm.surname, title: "Фамилия")
                    LunchTextField(prompt: "Ваш ник в телеграм", text: $vm.tgContact, title: "ТГ-контакт")
                }
                
                Spacer()
                
                Button("Зарегистрироваться") {
                    contentViewModel.isLoggedIn = vm.signInButtonAction()
                }
                .buttonStyle(.lunchButton)
                
                HStack {
                    Text("Уже зарегистрированы?")
                        .fontWeight(.light)
                    NavigationLink {
                        LoginView()
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
    SignUpView()
}
