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
}

protocol AuthClient {
    func login(with email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signup(with email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}

public final class FirebaseAC: AuthClient {
    func login(with email: String,
               password: String,
               completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, err in
            if let error = err {
                completion(.failure(error))
                return
            }

            guard let result = result else {
                completion(.failure(AuthError.parseFailed))
                return
            }

            completion(.success(result.user))
        }
    }

    func signup(with email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { result, err in
            if let error = err {
                completion(.failure(error))
                return
            }

            guard let result = result else {
                completion(.failure(AuthError.parseFailed))
                return
            }

            completion(.success(result.user))
        }
    }
}
