//
//  LoaderView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 02/04/22.
//

import SwiftUI

struct LoaderView: View {
    private typealias Colors = Asset.Assets.Color

    @State private var isLoading = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.2), lineWidth: 14)
                .frame(width: 50, height: 50)

            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color(Colors.green.name), lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(.default.repeatForever(autoreverses: false))
                .onAppear {
                    isLoading = true
                }
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
