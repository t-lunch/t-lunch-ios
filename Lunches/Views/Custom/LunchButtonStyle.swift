//
//  LunchButtonStyle.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct LunchButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(18)
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .background(configuration.isPressed ? Color(.systemGray6) : .tYellow)
            .cornerRadius(10)
            .padding(.horizontal, 25)
    }
}

extension ButtonStyle where Self == LunchButtonStyle {
    static var lunchButton: LunchButtonStyle {
        LunchButtonStyle()
    }
}

struct SmallLunchButtonStyle: ButtonStyle {
    var hasJoined: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(15)
            .foregroundColor(.black)
            .background(
                configuration.isPressed
                    ? Color(.systemGray6)
                    : (hasJoined ? Color.gray.opacity(0.3) : Color.tYellow)
            )
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
    }
}

extension ButtonStyle where Self == SmallLunchButtonStyle {
    static func smallLunchButton(hasJoined: Bool = true) -> SmallLunchButtonStyle {
        SmallLunchButtonStyle(hasJoined: hasJoined)
    }
}

#Preview {
    Button("Вход") {}
        .buttonStyle(.lunchButton)
}
