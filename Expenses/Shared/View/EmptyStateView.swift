//
//  EmptyView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 26/03/22.
//

import SwiftUI

struct EmptyStateView: View {
    let image: String

    let text: String

    let textColor: Color

    let backgroundColor: Color

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 40) {
                Image(image)
                    .resizable()
                    .frame(width: 250, height: 250)

                Text(text)
                    .foregroundColor(textColor)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(image: "emptyCards",
                  text: "Ooops, it looks like you don't have any cards added.",
                  textColor: .black,
                  backgroundColor: .white)
    }
}
