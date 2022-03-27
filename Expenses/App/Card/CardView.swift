//
//  CardView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import SwiftUI

struct CardView: View {
    private typealias Colors = Asset.Assets.Color

    @ObservedObject private var viewModel = CardsViewModel()

    @State private var showAddCardView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.cardsVM.isEmpty {
                    List {
                        ForEach(viewModel.cardsVM, id: \.self) { item in
                            CardItemView(item: item)
                        }
                    }
                } else {
                    EmptyView(image: "emptyCards",
                              text: "Ooops, it looks like you don't have any cards added.",
                              textColor: Color(Colors.green.name),
                              backgroundColor: .white)
                }
            }
            .sheet(isPresented: $showAddCardView, onDismiss: {
                viewModel.getCards()
            }) {
                AddCardView()
            }
            .navigationTitle("Cards")
            .navigationBarItems(trailing: Button {
                showAddCardView = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
            })
        }
    }

    init() {
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

        viewModel.getCards()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
