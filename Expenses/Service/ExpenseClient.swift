//
//  ExpenseClient.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 30/03/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ExpenseServiceProtocol {
    func getExpenses(completion: @escaping((Result<[Expense], Error>) -> Void))
    func addExpense(item: Expense, completion: @escaping((Result<Expense, Error>) -> Void))
    func updateExpense(item: Expense, completion: @escaping((Result<Expense, Error>) -> Void))
    func removeExpense(with id: String, completion: @escaping((Result<Void, Error>) -> Void))
}

final class FirebaseExpenseClient {
    private var userID: String {
        guard let user = AuthViewModel.shared.user else {
            fatalError("The user is not logged in")
        }

        return user.id
    }

    private let collectionName: String = "expenses"
    private let db = Firestore.firestore()

    private var dbReference: CollectionReference {
        return db.collection(collectionName)
    }
}

extension FirebaseExpenseClient: ExpenseServiceProtocol {
    func getExpenses(completion: @escaping ((Result<[Expense], Error>) -> Void)) {
        dbReference.whereField("user", in: [userID]).getDocuments { snapshot, error in
            if let error = error {
                NSLog("There was an error trying to fetch the Expenses: \(error)")
                completion(.failure(error))
                return
            }

            guard let snapshot = snapshot else {
                completion(.failure(CustomError.noData))
                return
            }

            do {
                let expenses = try snapshot.documents.map({ try $0.data(as: Expense.self) })
                completion(.success(expenses))
            } catch {
                NSLog("There was an error trying to parse the Expenses response: \(error)")
                completion(.failure(error))
            }
        }
    }

    func addExpense(item: Expense, completion: @escaping ((Result<Expense, Error>) -> Void)) {
        do {
            _ = try dbReference.addDocument(from: item)
            completion(.success(item))
        } catch {
            NSLog("There was an error trying to save the Expense: \(error)")
            completion(.failure(error))
        }
    }

    func updateExpense(item: Expense, completion: @escaping ((Result<Expense, Error>) -> Void)) {
        // TODO
    }

    func removeExpense(with id: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        dbReference.whereField("id", in: [id]).getDocuments(completion: { snapshot, error in
            if let error = error {
                NSLog("There was an error trying to fetch the Expense before delete: \(error)")
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
                    NSLog("There was an error trying to delete the Expense: \(error)")
                    completion(.failure(error))
                    return
                }

                completion(.success(()))
            }
        })
    }
}
