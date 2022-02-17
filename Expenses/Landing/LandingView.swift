//
//  LandingView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 17/02/22.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        ZStack {
            Color.customBlue
                .ignoresSafeArea()
            
            VStack() {
                
                Spacer()
                
                Text("Keep track of your expenses on credit cards")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Image("landing")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Button {
                        //
                    } label: {
                        Text("Login")
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
                        Text("Signup")
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
