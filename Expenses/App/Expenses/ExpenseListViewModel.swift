//
//  ExpenseListViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 30/03/22.
//

import Foundation

enum LoadingState {
    case none
    case loading
    case success
    case error
}

final class ExpenseListViewModel: ObservableObject {
    private let client: ExpenseServiceProtocol

    // Output
    @Published var expensesVM: [ExpenseViewModel] = []
    @Published var showError: Bool = false
    @Published var loadingState: LoadingState = .none

    @Published var monthSelected: Month
    @Published var yearSelected: Int

    private var items: [Expense] = []

    var errorMessage: String = ""

    var totalAmount: String {
        return items.reduce(0.0, { $0 + $1.amount }).formatAsCurrency()
    }

    private let cardsVM: CardsViewModel

    init(cardsVM: CardsViewModel) {
        self.client = FirebaseExpenseClient()
        self.cardsVM = cardsVM

        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month], from: currentDate)
        self.monthSelected = Month(rawValue: components.month ?? 1) ?? .january
        self.yearSelected = components.year ?? 2022
    }

    init(client: ExpenseServiceProtocol, cardsVM: CardsViewModel) {
        self.client = client
        self.cardsVM = cardsVM

        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month], from: currentDate)
        self.monthSelected = Month(rawValue: components.month ?? 1) ?? .january
        self.yearSelected = components.year ?? 2022
    }

    private func createFilters() -> [Filter] {
        var filters = [Filter]()
        filters.append(MonthFilter(year: yearSelected, month: monthSelected))
        return filters
    }

    func getExpenses() {
        loadingState = .loading
        client.getExpenses(with: createFilters()) { result in
            switch result {
            case .success(let expenses):
                DispatchQueue.main.async {
                    self.items = expenses
                    self.expensesVM = expenses.map({ item in
                        guard let card = self.cardsVM.cardsVM.first(where: { $0.id == item.card }) else {
                            return ExpenseViewModel(item: item, card: CardViewModel.empty)
                        }

                        return ExpenseViewModel(item: item, card: card)
                    })
                    self.loadingState = .success
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                    self.loadingState = .error
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
                    self.expensesVM = self.items.map({ item in
                        guard let card = self.cardsVM.cardsVM.first(where: { $0.id == item.id }) else {
                            return ExpenseViewModel(item: item, card: CardViewModel.empty)
                        }

                        return ExpenseViewModel(item: item, card: card)
                    })
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

    private let card: CardViewModel

    var id: String {
        return expense.id
    }

    var description: String {
        return expense.description
    }

    var date: String {
        return expense.date.getFormattedDate(format: "dd/MM/yyyy")
    }

    var amount: String {
        return expense.amount.formatAsCurrency()
    }

    var expenseType: String {
        return expense.expenseType.rawValue
    }

    var expenseTypeIcon: String {
        return expense.expenseType.icon
    }

    var cardName: String {
        return card.name
    }

    init(item: Expense, card: CardViewModel) {
        expense = item
        self.card = card
    }
}
