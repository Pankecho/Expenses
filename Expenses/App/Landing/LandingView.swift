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

    @State var goToAuth: Bool = false

    @State private var viewModel: LandingViewModel

    var body: some View {
        NavigationView {
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

                    Image(Images.landing.name)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()

                    Spacer()

                    VStack(spacing: 20) {
                        Button {
                            goToAuth = true
                            viewModel.saveFirstTimeKey(with: true)
                        } label: {
                            Text(Strings.Button.next)
                                .fontWeight(.semibold)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color(Colors.orange.name))
                                .cornerRadius(8)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                .padding(20)
            }
            .navigationBarHidden(true)
        }
    }

    init(vm: LandingViewModel) {
        self.viewModel = vm

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        // Tint color for back button
        UINavigationBar.appearance().tintColor = .white
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(vm: LandingViewModel())
    }
}
