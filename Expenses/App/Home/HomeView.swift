//
//  HomeView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 07/03/22.
//

import SwiftUI

struct HomeView: View {
    private typealias Colors = Asset.Assets.Color
    private typealias Strings = L10n.Home.Tabs

    @State var tagSelected: Int = 0

    private let cardsViewModel = CardsViewModel()

    var body: some View {
        TabView(selection: $tagSelected) {
            CardView(vm: cardsViewModel)
                .tabItem {
                    Image(systemName: "creditcard")
                    Text(Strings.cardsTitle)
                }
                .tag(0)

            Text("Expenses")
                .tabItem {
                    Image(systemName: "banknote")
                    Text(Strings.expensesTitle)
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text(Strings.settingsTitle)
                }
                .tag(2)
        }
        .accentColor(.white)
    }

    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color(Colors.blue.name))
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UITabBar.appearance().isTranslucent = true
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
