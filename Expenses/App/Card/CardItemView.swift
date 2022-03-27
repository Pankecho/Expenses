//
//  CardRowItem.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 26/03/22.
//

import SwiftUI

struct CardItemView: View {
    private let viewModel: CardViewModel

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.name)
                    .fontWeight(.semibold)

                Text(viewModel.bank)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 0) {
                Text(viewModel.creditLimit)
                    .fontWeight(.medium)

                Image(viewModel.cardType)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            }
        }
    }

    init(item: CardViewModel) {
        viewModel = item
    }
}

struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardItemView(item: CardViewModel(c: Card(id: UUID().uuidString,
                                                 name: "Black Platino",
                                                 type: .amex,
                                                 bank: .hsbc,
                                                 limit: 10000,
                                                 closingDay: 15,
                                                 payDay: 1,
                                                 user: "pankecho")))
    }
}
