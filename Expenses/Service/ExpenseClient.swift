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
    func getExpenses(with filters: [Filter], completion: @escaping((Result<[Expense], Error>) -> Void))
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

    private func injectUser(with filters: [Filter]) -> [Filter] {
        var newFilters = filters
        newFilters.append(UserFilter(value: userID))
        return newFilters
    }
}

extension FirebaseExpenseClient: ExpenseServiceProtocol {
    func getExpenses(with filters: [Filter], completion: @escaping ((Result<[Expense], Error>) -> Void)) {
        dbReference.whereFields(with: injectUser(with: filters)).getDocuments { snapshot, error in
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

extension CollectionReference {
    func whereFields(with filters: [Filter]) -> Query {
        var query: Query = whereField("", in: [])
        for filter in filters {
            switch filter.type {
            case .month:
                if let filter = filter as? MonthFilter {
                    query = query.whereField(value: filter)
                }
            case .userID:
                if let filter = filter as? UserFilter {
                    query = query.whereField(filter.queryName, isEqualTo: filter.value)
                }
            }
        }
        return query
    }
}

extension Query {
    func whereField(value: MonthFilter) -> Query {
        let filterComponents = DateComponents(year: value.year, month: value.month.rawValue)
        guard let date = Calendar.current.date(from: filterComponents) else {
            fatalError("Couldn't create date from filter")
        }

        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)

        guard
            let range = Calendar.current.range(of: .day, in: .month, for: date),
            let start = Calendar.current.date(from: components),
            let end = Calendar.current.date(byAdding: .day, value: range.count - 1, to: start) else {
                fatalError("Couldn't find start date or calculate end date")
            }
        return whereField(value.queryName, isGreaterThan: start).whereField(value.queryName, isLessThan: end)
    }
}
