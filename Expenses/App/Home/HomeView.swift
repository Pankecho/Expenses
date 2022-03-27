//
//  HomeView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 07/03/22.
//

import SwiftUI

struct HomeView: View {
    typealias Colors = Asset.Assets.Color

    @State var tagSelected: Int = 0

    var body: some View {
        TabView(selection: $tagSelected) {
            CardView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Cards")
                }
                .tag(0)

            Text("Expenses")
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Expenses")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
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
