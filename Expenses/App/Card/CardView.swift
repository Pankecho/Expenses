//
//  CardView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import SwiftUI

struct CardView: View {
    private typealias Strings = L10n.Auth

    @ObservedObject private var viewModel = CardsViewModel()

    @State private var showAddCardView: Bool = false

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.cardsVM, id: \.self) { item in
                    CardItemView(item: item)
                }
            }

            Button {
                showAddCardView = true
            } label: {
                Text("Add card")
                    .foregroundColor(.black)
            }
            .sheet(isPresented: $showAddCardView) {
                AddCardView()
            }
        }
        .onAppear {
            viewModel.getCards()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

struct CardItemView: View {
    private let viewModel: CardViewModel

    var body: some View {
        HStack {
            Text(viewModel.name)
                .fontWeight(.semibold)

            Text(viewModel.creditLimit)
        }
    }

    init(item: CardViewModel) {
        viewModel = item
    }
}
