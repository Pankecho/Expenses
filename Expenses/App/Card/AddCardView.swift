//
//  AddCardView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 25/03/22.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.presentationMode) private var presentationMode

    private typealias Strings = L10n.Cards.Add
    private typealias Colors = Asset.Assets.Color

    @ObservedObject private var viewModel: AddCardViewModel = AddCardViewModel()

    var body: some View {
        ZStack {
            Color(Colors.green.name)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }
                    Spacer()

                    Button {
                        viewModel.addCard { success in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text(Strings.Button.save)
                            .fontWeight(.semibold)
                            .padding([.leading, .trailing], 40)
                            .padding([.top, .bottom], 8)
                            .foregroundColor(Color(Colors.green.name))
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                }
                .padding()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        CommonTextField(title: Strings.name,
                                        text: $viewModel.name,
                                        placeholder: "Visa Rappi",
                                        textColor: .black,
                                        borderColor: .clear,
                                        icon: "creditcard.circle",
                                        iconColor: .black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        CommonTextField(title: Strings.creditLimit,
                                        text: $viewModel.limit,
                                        placeholder: "",
                                        textColor: .black,
                                        borderColor: .clear,
                                        icon: "dollarsign.circle",
                                        iconColor: .black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        PickerField(title: Strings.cardType,
                                    textColor: .black,
                                    borderColor: .clear,
                                    icon: "",
                                    iconColor: .black,
                                    picker: AnyView(Picker(selection: $viewModel.type) {
                            ForEach(CardType.allCases, id: \.self) { type in
                                Text(type.stringValue)
                                    .tag(type)
                            }
                        } label: {
                            HStack {
                                Text(viewModel.type.stringValue)
                                    .foregroundColor(.black)
                                Image("\(viewModel.type.rawValue)")
                            }
                        }))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        PickerField(title: Strings.bank,
                                    textColor: .black,
                                    borderColor: .clear,
                                    icon: "building.columns.circle",
                                    iconColor: .black,
                                    picker: AnyView(Picker("", selection: $viewModel.bank, content: {
                            ForEach(Bank.allCases, id: \.self) { type in
                                Text(type.rawValue)
                                    .tag(type)
                            }
                        })))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        PickerField(title: Strings.closingDay,
                                    textColor: .black,
                                    borderColor: .clear,
                                    icon: "calendar.circle",
                                    iconColor: .black,
                                    picker: AnyView(Picker("", selection: $viewModel.closingDay, content: {
                            ForEach(1...31, id: \.self) { day in
                                Text("\(day)")
                                    .tag(day)
                            }
                        })))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        PickerField(title: Strings.limitDay,
                                    textColor: .black,
                                    borderColor: .clear,
                                    icon: "calendar.circle",
                                    iconColor: .black,
                                    picker: AnyView(Picker("", selection: $viewModel.limit, content: {
                            ForEach(1...31, id: \.self) { day in
                                Text("\(day)")
                                    .tag(day)
                            }
                        })))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding([.bottom])
                }
                .padding([.leading, .trailing])
            }
        }
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}
