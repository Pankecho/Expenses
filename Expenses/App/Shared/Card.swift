//
//  Card.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import Foundation

public enum CardType: String, Codable {
    case visa
    case mastercard
    case amex
}

public struct Card: Codable {
    let name: String
    let type: CardType
    let bank: Bank
    let limit: Double
    let closingDay: Int
    let payDay: Int
}
