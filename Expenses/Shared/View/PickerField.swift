//
//  PickerField.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 27/03/22.
//

import SwiftUI

struct PickerField: View {
    let title: String

    let textColor: Color

    let borderColor: Color

    let icon: String?

    let iconColor: Color

    let picker: AnyView

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

                picker
                    .foregroundColor(textColor)
            }

            Divider()
                .frame(height: 1)
                .background(borderColor)
        }
    }
}
