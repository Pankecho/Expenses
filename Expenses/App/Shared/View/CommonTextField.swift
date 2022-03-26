//
//  CommonTextField.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import SwiftUI

struct CommonTextField: View {
    let title: String

    @Binding var text: String

    let placeholder: String

    let textColor: Color

    let borderColor: Color

    let icon: String?

    let iconColor: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(textColor)
                .fontWeight(.semibold)

            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                }

                TextField(placeholder, text: $text)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .foregroundColor(textColor)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }

            Divider()
                .frame(height: 1)
                .background(borderColor)
        }
    }
}
