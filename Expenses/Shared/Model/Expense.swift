//
//  Expense.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import Foundation

public enum ExpenseType: String, CaseIterable, Codable {
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

extension ExpenseType {
    var icon: String {
        switch self {
        case .clothing:
            return "tshirt.fill"
        case .education:
            return "books.vertical.fill"
        case .electronics:
            return "iphone.homebutton"
        case .health:
            return "heart.text.square.fill"
        case .restaurants:
            return "fork.knife"
        case .services:
            return "gamecontroller.fill"
        case .supermarket:
            return "cart.fill"
        case .transport:
            return "car.fill"
        case .others:
            return "bookmark.fill"
        }
    }
}

public struct Expense: Codable, Hashable {
    let id: String
    let description: String
    let amount: Double
    let date: Date
    let expenseType: ExpenseType
    let card: String
    let user: String
}
