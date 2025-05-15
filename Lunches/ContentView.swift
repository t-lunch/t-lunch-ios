//
//  ContentView.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        Group {
            if viewModel.isAuthorized {
                MainView(viewModel: viewModel.makeMainViewModel())
            } else {
                LoginView(viewModel: viewModel.makeLoginViewModel())
            }
        }
        .alert(item: $viewModel.globalError) { errorMessage in
            Alert(
                title: Text("Ошибка"),
                message: Text(errorMessage),
                dismissButton: .default(Text("Ок")) {
                    viewModel.clearError()
                }
            )
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModelFactory.previewContent.makeContentViewModel())
}
