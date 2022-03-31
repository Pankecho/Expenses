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

    private var items: [Expense] = []

    var errorMessage: String = ""

    init(client: ExpenseServiceProtocol) {
        self.client = client
    }

    init() {
        self.client = FirebaseExpenseClient()
    }

    func getExpenses() {
        client.getExpenses { result in
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

    var description: String {
        return expense.description
    }

    var date: String {
        return expense.date.getFormattedDate(format: "dd/MM/yyyy HH:mm:ss")
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
