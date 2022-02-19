//
//  Expense.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import Foundation

public enum ExpenseType: String, Codable {
    case clothing = "Clothing"
    case education = "Education"
    case electronics = "Electronics"
    case health = "Health"
    case restaurants = "Restaurants"
    case services = "Services"
    case supermarket = "Supermarket"
    case transport = "Transport"
    case others = "Others"
}

public struct Expense: Codable {
    let id: String
    let description: String
    let amount: Double
    let date: Date
    let expenseType: ExpenseType
}
