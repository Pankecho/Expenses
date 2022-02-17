//
//  LandingView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import SwiftUI

struct LandingView: View {
    typealias Strings = L10n.Landing
    typealias Images = Asset.Assets.Image
    typealias Colors = Asset.Assets.Color

    var body: some View {
        ZStack {
            Color(Colors.blue.color)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text(Strings.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Spacer()

                Image(Images.landing.name)
                    .resizable()
                    .frame(width: 150, height: 150)

                Spacer()

                VStack(spacing: 20) {
                    Button {
                        //
                    } label: {
                        Text(Strings.Button.login)
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.customOrange)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    Button {
                        //
                    } label: {
                        Text(Strings.Button.signup)
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.customYellow)
                    }
                }
            }
            .padding(20)
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
