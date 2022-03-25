//
//  LandingViewModel.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import Foundation

final class LandingViewModel: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let fistTimeKey: String = "userHasLaunchedApp"

    @Published var hasLandingLoaded: Bool = false

    init() {
        loadData()
    }

    func saveFirstTimeKey(with value: Bool) {
        hasLandingLoaded = value
        userDefaults.set(value, forKey: fistTimeKey)
    }

    private func loadData() {
        let value = userDefaults.bool(forKey: fistTimeKey)
        hasLandingLoaded = value
    }
}
