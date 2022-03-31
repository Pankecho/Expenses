//
//  AddExpenseViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 30/03/22.
//

import Foundation

final class AddExpenseViewModel: ObservableObject {
    private let client: ExpenseServiceProtocol

    private var userID: String {
        guard let user = AuthViewModel.shared.user else {
            fatalError("User is not logged in")
        }
        return user.id
    }

    // Input
    @Published var description: String = ""
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var type: ExpenseType = .others
    @Published var card: String = ""

    // Output
    @Published var showError: Bool = false

    var errorMessage: String = ""

    func addCard(completion: @escaping((Bool) -> Void)) {
        guard let amount = Double(amount), amount > 0 else {
            return
        }

        let expense = Expense(id: UUID().uuidString,
                              description: description,
                              amount: amount,
                              date: date,
                              expenseType: type,
                              card: card,
                              user: userID)

        client.addExpense(item: expense) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }

    init() {
        self.client = FirebaseExpenseClient()
    }

    init(client: ExpenseServiceProtocol) {
        self.client = client
    }
}
