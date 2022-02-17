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

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        ZStack {
            Color(Colors.blue.name)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 40) {

                    Image(Images.budget.name)
                        .resizable()
                        .frame(width: 150, height: 150)

                    VStack(alignment: .leading) {
                        Text(Strings.email)
                            .foregroundColor(.white)

                        TextField(Strings.emailPlaceholder, text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .foregroundColor(.white)

                        Divider()
                            .frame(height: 1)
                            .background(Color(Colors.green.name))
                    }

                    VStack(alignment: .leading) {
                        Text(Strings.password)
                            .foregroundColor(.white)

                        SecureField("", text: $password)
                            .textContentType(.password)
                            .foregroundColor(.white)

                        VStack(alignment: .trailing) {
                            Divider()
                                .frame(height: 1)
                                .background(Color(Colors.green.name))

                            if authType == .login {
                                Button {
                                    //
                                } label: {
                                    Text(Strings.Button.forgotPassword)
                                        .multilineTextAlignment(.trailing)
                                        .font(.footnote)
                                        .foregroundColor(Color(Colors.green.name))
                                }
                            }
                        }
                    }

                    Button {
                        // TODO
                    } label: {
                        Text(authType == .login ? Strings.Button.login : Strings.Button.signup)
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.customOrange)
                    }
                }
                .padding()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }

    init(authType: AuthType) {
        self.authType = authType
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authType: .login)
    }
}
