//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import SwiftUI
import Firebase

@main
struct ExpensesApp: App {
    @StateObject var authenticationViewModel = AuthViewModel.shared
    @StateObject var landingViewModel = LandingViewModel()

    var body: some Scene {
        WindowGroup {
            if let user = authenticationViewModel.user {
                VStack {
                    Text("User: \(user.email) - \(user.id)")
                    Button {
                        authenticationViewModel.signOut()
                    } label: {
                        Text("Sign out")
                    }
                }
            } else {
                if landingViewModel.hasLandingLoaded {
                    AuthView()
                } else {
                    LandingView(vm: landingViewModel)
                }
            }
        }
    }

    init() {
        FirebaseApp.configure()
    }
}
