//
//  Double.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 26/03/22.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
