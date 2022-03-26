//
//  CardListViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import Foundation

final class CardsViewModel: ObservableObject {
    private let client: CardServiceProtocol

    // Output
    @Published var cardsVM: [CardViewModel] = []
    @Published var showError: Bool = false

    private var cards: [Card] = []

    var errorMessage: String = ""

    init() {
        guard let user = AuthViewModel.shared.user else {
            fatalError("User is not logged in")
        }
        self.client = FirebaseCardClient(userId: user.id)
    }

    init(client: CardServiceProtocol) {
        self.client = client
    }

    func getCards() {
        client.getCards { result in
            switch result {
            case .success(let cards):
                let cardsVM = cards.map({ CardViewModel(c: $0) })
                DispatchQueue.main.async {
                    self.cards = cards
                    self.cardsVM = cardsVM
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

struct CardViewModel: Hashable {
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.card.id == rhs.card.id
    }

    private let card: Card

    var name: String {
        return card.name
    }

    var bank: String {
        return card.bank.rawValue
    }

    var cardType: String {
        return card.type.rawValue
    }

    var creditLimit: String {
        return card.limit.formatAsCurrency()
    }

    init(c: Card) {
        self.card = c
    }
}