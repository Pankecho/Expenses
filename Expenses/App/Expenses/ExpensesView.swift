//
//  ExpensesView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 30/03/22.
//

import SwiftUI

struct ExpensesView: View {
    private typealias Colors = Asset.Assets.Color
    private typealias Strings = L10n.Expenses.List

    @ObservedObject private var expensesViewModel: ExpenseListViewModel
    @ObservedObject private var cardsViewModel: CardsViewModel

    @State private var showAddExpenseView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                switch expensesViewModel.loadingState {
                case .none:
                    Text("")
                case .loading:
                    LoaderView()
                case .success:
                    if !expensesViewModel.expensesVM.isEmpty {
                        List {
                            ForEach(expensesViewModel.expensesVM, id: \.id) { item in
                                ExpenseItemView(vm: item)
                            }
                            .onDelete { index in
                                guard let index = index.first else { return }
                                // TODO
                            }
                        }
                        // TODO: Add total amount view
                    } else {
                        EmptyStateView(image: "emptyExpenses",
                                       text: Strings.Empty.title,
                                       textColor: Color(Colors.green.name),
                                       backgroundColor: .white)
                    }
                case .error:
                    // TODO
                    Text("")
                }
            }
            .sheet(isPresented: $showAddExpenseView, onDismiss: {
                expensesViewModel.getExpenses()
            }) {
                AddExpenseView(cvm: cardsViewModel)
            }
            .navigationTitle(Strings.title)
            .navigationBarItems(trailing: Button {
                showAddExpenseView = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
            })
            .onAppear {
                self.expensesViewModel.getExpenses()
            }
        }
    }

    init(cvm: CardsViewModel, evm: ExpenseListViewModel) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().backgroundColor = UIColor(Color(Colors.blue.name))
        // Tint color for back button
        UINavigationBar.appearance().tintColor = .white

        self.expensesViewModel = evm
        self.cardsViewModel = cvm
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(cvm: ExpensesViewMock.cvm, evm: ExpensesViewMock.evm)
    }
}

struct ExpensesViewMock {
    static let cvm = CardsViewModel()
    static let evm = ExpenseListViewModel(cardsVM: ExpensesViewMock.cvm)
}
