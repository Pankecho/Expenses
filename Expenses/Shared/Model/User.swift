//
//  User.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import Foundation

struct User {
    let id: String
    let email: String
    let name: String

    init(id: String, email: String) {
        self.id = id
        self.email = email
        self.name = ""
    }
}
