//
//  AuthViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 21/02/22.
//

import Foundation
import Combine
import FirebaseAuth
import AVFoundation

enum LoadingState {
    case loading, success, error(String), none
}

public class ViewModel: ObservableObject {
    @Published var loadingState: LoadingState = .none
}

enum LoginState {
    case none
    case loggedIn
}

public final class AuthViewModel: ViewModel {
    // Input
    @Published var email = ""
    @Published var password = ""

    @Published var showPassword = false
    @Published var loginStatus: LoginState = .none

    private let client: AuthClient

    init(client: AuthClient) {
        self.client = client
    }

    func login() {
        self.loadingState = .loading

        client.login(with: email,
                     password: password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.loginStatus = .loggedIn
                    self.loadingState = .success
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loginStatus = .none
                    self.loadingState = .error(error.localizedDescription)
                }
                break
            }
        }
    }

    func signup() {
        self.loadingState = .loading

        client.signup(with: email,
                      password: password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.loginStatus = .loggedIn
                    self.loadingState = .success
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loginStatus = .none
                    self.loadingState = .error(error.localizedDescription)
                }
                break
            }
        }
    }

    func toggleShowPassword() {
        showPassword.toggle()
    }
}
