//
//  PasswordTextField.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import SwiftUI

struct PasswordTextField: View {
    let title: String

    @Binding var text: String

    let textColor: Color

    let borderColor: Color

    let icon: String?

    let iconColor: Color

    let forgotPasswordTitle: String

    let showForgotPassword: Bool

    let forgotPasswordColor: Color

    @State private var showPassword: Bool = false

    private let hideIcon = "eye.slash.fill"
    private let showIcon = "eye.fill"

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.semibold)

            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                }

                if showPassword {
                    TextField("", text: $text)
                        .textContentType(.password)
                        .foregroundColor(textColor)
                } else {
                    SecureField("", text: $text)
                        .textContentType(.password)
                        .foregroundColor(textColor)
                }

                Image(systemName: showPassword ? hideIcon : showIcon)
                    .foregroundColor(iconColor)
                    .padding([.bottom, .trailing], 4)
                    .onTapGesture {
                        self.showPassword.toggle()
                    }
            }

            Divider()
                .frame(height: 1)
                .background(borderColor)

            if showForgotPassword {
                VStack(alignment: .trailing) {
                    Button {
                        //
                    } label: {
                        Text(forgotPasswordTitle)
                            .font(.footnote)
                            .foregroundColor(forgotPasswordColor)
                    }
                }
            }
        }
    }
}
