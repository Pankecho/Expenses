//
//  CardClient.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum CustomError: Error {
    case noData
    case multipleIDs
}

protocol CardServiceProtocol {
    func getCards(completion: @escaping((Result<[Card], Error>) -> Void))
    func addCard(card: Card, completion: @escaping((Result<Card, Error>) -> Void))
    func updateCard(card: Card, completion: @escaping((Result<Card, Error>) -> Void))
    func removeCard(with id: String, completion: @escaping((Result<Void, Error>) -> Void))
}

final class FirebaseCardClient: CardServiceProtocol {

    private let userID: String

    private let collectionName: String = "cards"
    private let db = Firestore.firestore()

    private var dbReference: CollectionReference {
        return db.collection(collectionName)
    }

    init(userId: String) {
        userID = userId
    }

    func getCards(completion: @escaping ((Result<[Card], Error>) -> Void)) {
        dbReference.whereField("user", in: [userID]).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let snapshot = snapshot else {
                completion(.failure(CustomError.noData))
                return
            }

            do {
                let cards = try snapshot.documents.map({ try $0.data(as: Card.self) })
                completion(.success(cards))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func addCard(card: Card, completion: @escaping ((Result<Card, Error>) -> Void)) {
        do {
            _ = try dbReference.addDocument(from: card)
            completion(.success(card))
        } catch {
            NSLog("There was an error trying to save the card: \(error)")
            completion(.failure(error))
        }
    }

    func updateCard(card: Card, completion: @escaping ((Result<Card, Error>) -> Void)) {
        //
    }

    func removeCard(with id: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        dbReference.whereField("id", in: [id]).getDocuments(completion: { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let snapshot = snapshot else {
                completion(.failure(CustomError.noData))
                return
            }

            guard let documentID = snapshot.documents.first?.documentID else {
                completion(.failure(CustomError.noData))
                return
            }

            self.dbReference.document(documentID).delete { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                completion(.success(()))
            }
        })
    }
}
