//
//  LoginView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import SwiftUI

struct AuthView: View {
    private let authType: AuthType

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

                    Image(Images.budget.name)
                        .resizable()
                        .frame(width: 150, height: 150)

                    CommonTextField(title: Strings.email,
                                    text: $viewModel.email,
                                    placeholder: Strings.emailPlaceholder,
                                    textColor: .white,
                                    borderColor: Color(Colors.green.name))

                    PasswordTextField(title: Strings.password,
                                      text: $viewModel.password,
                                      forgotPasswordTitle: Strings.Button.forgotPassword,
                                      showForgotPassword: authType == .login)

                    Button {
                        switch authType {
                        case .login:
                            viewModel.login()
                        case .signup:
                            viewModel.signup()
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
                }
                .padding()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }

    init(authType: AuthType) {
        self.authType = authType

        viewModel = AuthViewModel(client: FirebaseAC())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authType: .login)
    }
}

struct CommonTextField: View {
    let title: String

    @Binding var text: String

    let placeholder: String

    let textColor: Color

    let borderColor: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)

            TextField(placeholder, text: $text)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .foregroundColor(textColor)
                .disableAutocorrection(true)
                .autocapitalization(.none)

            Divider()
                .frame(height: 1)
                .background(borderColor)
        }
    }
}

struct PasswordTextField: View {
    typealias Colors = Asset.Assets.Color

    let title: String

    @State private var showPassword: Bool = false

    @Binding var text: String

    let forgotPasswordTitle: String
    let showForgotPassword: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)

            HStack {
                if showPassword {
                    TextField("", text: $text)
                        .textContentType(.password)
                        .foregroundColor(.white)
                } else {
                    SecureField("", text: $text)
                        .textContentType(.password)
                        .foregroundColor(.white)
                }

                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(Color(Colors.green.name))
                    .padding([.bottom, .trailing], 4)
                    .onTapGesture {
                        self.showPassword.toggle()
                    }
            }

            Divider()
                .frame(height: 1)
                .background(Color(Colors.green.name))

            if showForgotPassword {
                VStack(alignment: .trailing) {
                    Button {
                        //
                    } label: {
                        Text(forgotPasswordTitle)
                            .font(.footnote)
                            .foregroundColor(Color(Colors.green.name))
                    }
                }
            }
        }
    }
}
