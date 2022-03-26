//
//  Card.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import Foundation

public enum CardType: String, Codable, CaseIterable {
    case visa
    case mastercard
    case amex
}

extension CardType {
    var stringValue: String {
        switch self {
        case .visa:
            return "Visa"
        case .mastercard:
            return "Mastercard"
        case .amex:
            return "American Express"
        }
    }
}

public struct Card: Codable {
    let id: String
    let name: String
    let type: CardType
    let bank: Bank
    let limit: Double
    let closingDay: Int
    let payDay: Int
    let user: String
}

extension Card: Hashable { }

public struct CardResponse: Codable {
    let items: [Card]
}
