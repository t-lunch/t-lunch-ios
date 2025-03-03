//
//  LoginView.swift
//  Lunches
//
//  Created by Андрей Степанов on 24.02.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 90)
                VStack {
                    Text("Вход")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    LunchTextField(prompt: "Ваш логин", text: $vm.login, title: "Логин")
                    LunchTextField(text: $vm.password, title: "Пароль", isSecured: $vm.isPasswordFieldSecured)
                        .padding(.bottom, 20)
                    Button("Забыли пароль?") {
                        
                    }
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 25)
                }
                
                Spacer()
                
                Button("Войти") {
                    contentViewModel.isLoggedIn = vm.loginButtonAction()
                }
                .buttonStyle(.lunchButton)
                
                HStack {
                    Text("Еще нет аккаунта?")
                        .fontWeight(.light)
                    NavigationLink() {
                        SignUpView()
                    } label: {
                        Text("Зарегистрироваться")
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
    LoginView()
}
