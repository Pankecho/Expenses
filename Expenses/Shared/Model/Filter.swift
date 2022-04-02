//
//  Filter.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 02/04/22.
//

import Foundation

enum FilterType {
    case month
    case userID
}

protocol Filter {
    var queryName: String { get }
    var type: FilterType { get }
}

struct MonthFilter: Filter {
    let year: Int
    let month: Month

    var queryName: String {
        return "date"
    }

    var type: FilterType {
        return .month
    }
}

struct UserFilter: Filter {
    let value: String

    var queryName: String {
        return "user"
    }

    var type: FilterType {
        return .userID
    }
}

enum Month: Int, CaseIterable {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
}
