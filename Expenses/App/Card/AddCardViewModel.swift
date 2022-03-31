//
//  AddCardViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 26/03/22.
//

import Foundation

final class AddCardViewModel: ObservableObject {
    private let client: CardServiceProtocol

    private var userID: String {
        guard let user = AuthViewModel.shared.user else {
            fatalError("User is not logged in")
        }
        return user.id
    }

    // Input
    @Published var name: String = ""
    @Published var type: CardType = .visa
    @Published var bank: Bank = .bbva
    @Published var limit: String = ""
    @Published var closingDay: Int = 1
    @Published var payDay: Int = 1

    // Output
    @Published var showError: Bool = false

    var errorMessage: String = ""

    func addCard(completion: @escaping((Bool) -> Void)) {
        guard let limit = Double(limit) else {
            return
        }

        let card = Card(id: UUID().uuidString,
                        name: name,
                        type: type,
                        bank: bank,
                        limit: limit,
                        closingDay: closingDay,
                        payDay: payDay,
                        user: userID)

        client.addCard(card: card) { result in
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
        self.client = FirebaseCardClient()
    }

    init(client: FirebaseCardClient) {
        self.client = client
    }
}
