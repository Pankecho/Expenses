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
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }

    init() {
        FirebaseApp.configure()
    }
}
