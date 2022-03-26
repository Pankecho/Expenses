//
//  LoginView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import SwiftUI

enum AuthType {
    case login
    case signup
}

struct AuthView: View {
    @State private var authType: AuthType = .login

    typealias Strings = L10n.Auth
    typealias Images = Asset.Assets.Image
    typealias Colors = Asset.Assets.Color

    @ObservedObject private var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color(Colors.blue.name)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 40) {

                    Image(authType == .login ? Images.budget.name : Images.savings.name)
                        .resizable()
                        .frame(width: 150, height: 150)

                    CommonTextField(title: Strings.email,
                                    text: $viewModel.email,
                                    placeholder: Strings.emailPlaceholder,
                                    textColor: .white,
                                    borderColor: Color(Colors.green.name),
                                    icon: "envelope",
                                    iconColor: Color(Colors.green.name))

                    PasswordTextField(title: Strings.password,
                                      text: $viewModel.password,
                                      textColor: .white,
                                      borderColor: Color(Colors.green.name),
                                      icon: "lock",
                                      iconColor: Color(Colors.green.name),
                                      forgotPasswordTitle: Strings.Button.forgotPassword,
                                      showForgotPassword: authType == .login,
                                      forgotPasswordColor: Color(Colors.green.name))

                    Button {
                        switch authType {
                        case .login:
                            viewModel.login()
                        case .signup:
                            viewModel.createUser()
                        }
                    } label: {
                        Text(authType == .login ? Strings.Button.login : Strings.Button.signup)
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color(Colors.orange.name))
                            .cornerRadius(8)
                    }

                    Button {
                        switch authType {
                        case .login:
                            authType = .signup
                        case .signup:
                            authType = .login
                        }
                    } label: {
                        Text(authType == .login ? Strings.Button.dontHaveAccount : Strings.Button.alreadyHaveAccount)
                            .foregroundColor(Color(Colors.orange.name))
                            .fontWeight(.semibold)
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text(Strings.Alert.title),
                      message: Text(viewModel.errorMessage),
                      dismissButton: .default(Text(Strings.Alert.Button.ok)) { })
            }
        }
    }

    init() {
        self.viewModel = AuthViewModel.shared
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
