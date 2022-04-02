//
//  CardView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import SwiftUI

struct CardView: View {
    private typealias Colors = Asset.Assets.Color
    private typealias Strings = L10n.Cards.List

    @ObservedObject private var viewModel: CardsViewModel

    @State private var showAddCardView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.loadingState {
                case .none:
                    Text("")
                case .loading:
                    LoaderView()
                case .success:
                    if !viewModel.cardsVM.isEmpty {
                        List {
                            ForEach(viewModel.cardsVM, id: \.self) { item in
                                CardItemView(item: item)
                            }
                            .onDelete { index in
                                guard let index = index.first else { return }
                                viewModel.deleteCard(at: index)
                            }
                        }
                    } else {
                        EmptyStateView(image: "emptyCards",
                                       text: Strings.Empty.title,
                                       textColor: Color(Colors.green.name),
                                       backgroundColor: .white)
                    }
                case .error:
                    // TODO
                    Text("")
                }
            }
            .sheet(isPresented: $showAddCardView, onDismiss: {
                viewModel.getCards()
            }) {
                AddCardView()
            }
            .navigationTitle(Strings.title)
            .navigationBarItems(trailing: Button {
                showAddCardView = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
            })
        }
    }

    init(vm: CardsViewModel) {
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

        viewModel = vm
        viewModel.getCards()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(vm: CardsViewModel())
    }
}
