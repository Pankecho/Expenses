//
//  ExpenseItemView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 02/04/22.
//

import SwiftUI

struct ExpenseItemView: View {
    private let viewModel: ExpenseViewModel

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: viewModel.expenseTypeIcon)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.description)
                    .fontWeight(.medium)

                Text("\(viewModel.expenseType) | \(viewModel.cardName)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(viewModel.amount)
                    .font(.callout)
                    .fontWeight(.medium)

                Text(viewModel.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }

    init(vm: ExpenseViewModel) {
        self.viewModel = vm
    }
}

struct ExpenseItemView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseItemView(vm: .init(item: .init(id: "123",
                                              description: "Ropa",
                                              amount: 500,
                                              date: Date(),
                                              expenseType: .clothing,
                                              card: "",
                                              user: ""),
                                  card: .init(c: .init(id: "",
                                                       name: "BBVA",
                                                       type: .visa,
                                                       bank: .banamex,
                                                       limit: 100,
                                                       closingDay: 5,
                                                       payDay: 1,
                                                       user: ""))))
    }
}
