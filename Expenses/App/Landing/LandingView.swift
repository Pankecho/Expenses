//
//  LandingView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import SwiftUI

enum AuthType {
    case login
    case signup
}

struct LandingView: View {
    typealias Strings = L10n.Landing
    typealias Images = Asset.Assets.Image
    typealias Colors = Asset.Assets.Color

    @State var goToAuth: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(Colors.blue.color)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    Text(Strings.title)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Image(Images.landing.name)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()

                    Spacer()

                    VStack(spacing: 20) {
                        NavigationLink(destination: AuthView(authType: .login),
                                       isActive: $goToAuth) {
                            Button {
                                goToAuth = true
                            } label: {
                                Text(Strings.Button.login)
                                    .fontWeight(.semibold)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .background(Color(Colors.orange.name))
                                    .cornerRadius(8)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }

                        NavigationLink(destination: AuthView(authType: .signup),
                                       isActive: $goToAuth) {
                            Button {
                                goToAuth = true
                            } label: {
                                Text(Strings.Button.signup)
                                    .fontWeight(.semibold)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color(Colors.yellow.name))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(20)
            }
            .navigationBarHidden(true)
        }
    }

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        // Tint color for back button
        UINavigationBar.appearance().tintColor = .white
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
