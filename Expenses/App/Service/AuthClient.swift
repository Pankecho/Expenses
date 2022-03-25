//
//  Client.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 07/03/22.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    case parseFailed
    case noData
}

protocol AuthServiceProtocol {
    var currentUser: User? { get }
    func signUp(email: String, password: String, completion: @escaping((Result<User, Error>) -> Void))
    func signIn(email: String, password: String, completion: @escaping((Result<User, Error>) -> Void))
    func signOut(completion: @escaping((Result<Void, Error>) -> Void))
    func sendPasswordReset(email: String, completion: @escaping((Result<Bool, Error>) -> Void))
}

public final class FirebaseAuthClient: AuthServiceProtocol {
    private let client = Auth.auth()

    var currentUser: User? {
        guard let email = client.currentUser?.email, let id = client.currentUser?.uid else {
            return nil
        }

        return .init(id: id, email: email)
    }

    func signUp(email: String, password: String, completion: @escaping ((Result<User, Error>) -> Void)) {
        client.createUser(withEmail: email,
                          password: password) { result, err in
            if let error = err {
                completion(.failure(error))
                return
            }

            guard let user = result?.user else {
                completion(.failure(AuthError.parseFailed))
                return
            }

            guard let email = user.email else {
                completion(.failure(AuthError.noData))
                return
            }

            completion(.success(.init(id: user.uid, email: email)))
        }
    }

    func signIn(email: String, password: String, completion: @escaping ((Result<User, Error>) -> Void)) {
        client.signIn(withEmail: email,
                      password: password) { result, err in
            if let error = err {
                completion(.failure(error))
                return
            }

            guard let user = result?.user else {
                completion(.failure(AuthError.parseFailed))
                return
            }

            guard let email = user.email else {
                completion(.failure(AuthError.noData))
                return
            }

            completion(.success(.init(id: user.uid, email: email)))
        }
    }

    func signOut(completion: @escaping ((Result<Void, Error>) -> Void)) {
        do {
            try client.signOut()
            completion(.success(()))
        } catch {
            NSLog("Error while trying to signOut: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    func sendPasswordReset(email: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        // TODO
    }
}
