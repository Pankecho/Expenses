//
//  Date.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 30/03/22.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
