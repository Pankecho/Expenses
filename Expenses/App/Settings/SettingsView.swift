//
//  SettingsView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 26/03/22.
//

import SwiftUI

struct SettingsView: View {
    private typealias Colors = Asset.Assets.Color

    private let authViewModel = AuthViewModel.shared

    var body: some View {
        VStack(spacing: 40) {

            Spacer()

            Text(authViewModel.user?.email ?? "No Email")

            Text(authViewModel.user?.id ?? "No ID")

            Spacer()

            Button {
                authViewModel.signOut()
            } label: {
                // TODO: Add strings
                Text("Log out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(Colors.red.name))
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
