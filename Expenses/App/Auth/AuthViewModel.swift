//
//  AuthViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 21/02/22.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {

    static let shared = AuthViewModel(client: FirebaseAuthClient())

    private let authClient: AuthServiceProtocol

    // Input
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showError: Bool = false

    // Output
    @Published var isValid: Bool = false
    // TODO: Expose this so we can let the user know the email is not valid
    @Published private var isEmailValid: Bool = false
    // TODO: Expose this so we can let the user know the password is not valid
    @Published private var isPasswordValid: Bool = false

    @Published private(set) var user: User?

    var errorMessage: String = ""

    private var cancellableSet: Set<AnyCancellable> = []

    private init(client: AuthServiceProtocol) {
        self.authClient = client
        self.user = authClient.currentUser

        $email
            .receive(on: RunLoop.main)
            .map { email in
                let pattern = #"^\S+@\S+\.\S+$"#
                if let _ = email.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellableSet)

        $password
            .receive(on: RunLoop.main)
            .map { $0.count >= 8 }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellableSet)

        Publishers.CombineLatest($isEmailValid, $isPasswordValid)
            .receive(on: RunLoop.main)
            .map { $0 && $1 }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }

    func createUser() {
        authClient.signUp(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.user = user
                DispatchQueue.main.async {
                    // TODO
                    self.clear()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func login() {
        authClient.signIn(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.user = user
                DispatchQueue.main.async {
                    // TODO
                    self.clear()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func signOut() {
        authClient.signOut { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    // TODO
                    self.clear()
                    self.user = self.authClient.currentUser
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func clear() {
        email = ""
        password = ""
    }
}
