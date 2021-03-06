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
    @Published var loadingState: LoadingState = .none

    private var cards: [Card] = []

    var errorMessage: String = ""

    init() {
        self.client = FirebaseCardClient()
    }

    init(client: CardServiceProtocol) {
        self.client = client
    }

    func getCards() {
        loadingState = .loading
        client.getCards { result in
            switch result {
            case .success(let cards):
                let cardsVM = cards.map({ CardViewModel(c: $0) })
                DispatchQueue.main.async {
                    self.cards = cards
                    self.cardsVM = cardsVM
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

    func deleteCard(at index: Int) {
        let item = cards[index]
        client.removeCard(with: item.id) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.cards.remove(at: index)
                    let cardsVM = self.cards.map({ CardViewModel(c: $0) })
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

    var id: String {
        return card.id
    }

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

extension CardViewModel {
    static let empty = CardViewModel(c: Card(id: "", name: "", type: .mastercard, bank: .banamex, limit: 0.0, closingDay: 1, payDay: 1, user: ""))
}
