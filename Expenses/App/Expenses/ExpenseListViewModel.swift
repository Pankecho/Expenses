//
//  ExpenseListViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 30/03/22.
//

import Foundation

final class ExpenseListViewModel: ObservableObject {
    private let client: ExpenseServiceProtocol

    // Output
    @Published var expensesVM: [ExpenseViewModel] = []
    @Published var showError: Bool = false

    @Published var monthSelected: Month
    @Published var yearSelected: Int

    private var items: [Expense] = []

    var errorMessage: String = ""

    var totalAmount: String {
        return items.reduce(0.0, { $0 + $1.amount }).formatAsCurrency()
    }

    init(client: ExpenseServiceProtocol) {
        self.client = client
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month], from: currentDate)
        self.monthSelected = Month(rawValue: components.month ?? 1) ?? .january
        self.yearSelected = components.year ?? 2022
    }

    init() {
        self.client = FirebaseExpenseClient()
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month], from: currentDate)
        self.monthSelected = Month(rawValue: components.month ?? 1) ?? .january
        self.yearSelected = components.year ?? 2022
    }

    func getExpenses() {
        client.getExpenses(with: [ MonthFilter(year: yearSelected, month: monthSelected) ]) { result in
            switch result {
            case .success(let expenses):
                DispatchQueue.main.async {
                    self.items = expenses
                    self.expensesVM = expenses.map({ ExpenseViewModel(item: $0) })
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func deleteExpense(at index: Int) {
        let item = items[index]
        client.removeExpense(with: item.id) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.items.remove(at: index)
                    self.expensesVM = self.items.map({ ExpenseViewModel(item: $0) })
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct ExpenseViewModel: Hashable {
    static func == (lhs: ExpenseViewModel, rhs: ExpenseViewModel) -> Bool {
        return lhs.expense.id == rhs.expense.id
    }

    private let expense: Expense

    var id: String {
        return expense.id
    }

    var description: String {
        return expense.description
    }

    var date: String {
        return expense.date.getFormattedDate(format: "dd/MM/yyyy")
    }

    var expenseType: String {
        return expense.expenseType.rawValue
    }

    var expenseTypeIcon: String {
        return expense.expenseType.icon
    }

    init(item: Expense) {
        expense = item
    }
}
