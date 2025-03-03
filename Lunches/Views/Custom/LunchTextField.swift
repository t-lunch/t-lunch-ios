//
//  LunchTextField.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct LunchTextField: View {
    var prompt: String = ""
    var text: Binding<String>
    var title: String? = nil
    var isSecured: Binding<Bool>? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if title != nil {
                Text(title!)
                    .font(.system(size: 14))
            }
            
            HStack {
                if isSecured != nil {
                    if isSecured!.wrappedValue {
                        SecureField(prompt, text: text)
                            .padding()
                    } else {
                        TextField(prompt, text: text)
                            .padding()
                    }
                    
                    Spacer()
                
                    Button {
                        isSecured!.wrappedValue.toggle()
                    } label: {
                        if #available(iOS 17.0, *) {
                            Image(systemName: isSecured!.wrappedValue ? "eye.slash" : "eye")
                                .contentTransition(.symbolEffect(.replace))
                                .frame(height: 22)
                        } else {
                            Image(systemName: isSecured!.wrappedValue ? "eye.slash" : "eye")
                                .frame(height: 22)
                        }
                    }
                    .padding()
                    .foregroundStyle(.gray)
                }
                
                else {
                    TextField(prompt, text: text)
                        .padding()
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .fill(Color(.systemGray4))
            }
        }
        .padding(.horizontal, 25)
    }
}


#Preview {
    LunchTextField(prompt: "Ваш логин",
                   text: Binding( get: { "" }, set: { _ in }),
                   title: "Логин")
    
    LunchTextField(text: Binding( get: { "" }, set: { _ in }),
                   title: "Пароль",
                   isSecured: Binding( get: { true }, set: { _ in }))
}
