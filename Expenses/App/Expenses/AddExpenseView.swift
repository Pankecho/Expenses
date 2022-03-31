//
//  AddExpenseView.swift
//  Expenses
//
//  Created by Juan Pablo Martinez Ruiz on 30/03/22.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) private var presentationMode

    private typealias Strings = L10n.Expenses.Add
    private typealias Colors = Asset.Assets.Color

    @ObservedObject private var addExpenseViewModel: AddExpenseViewModel = AddExpenseViewModel()

    @ObservedObject private var cardsViewModel: CardsViewModel

    var body: some View {
        ZStack {
            Color(Colors.yellow.name)
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
                        addExpenseViewModel.addExpense { success in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text(Strings.Button.save)
                            .fontWeight(.semibold)
                            .padding([.leading, .trailing], 40)
                            .padding([.top, .bottom], 8)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                }
                .padding()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        CommonTextField(title: Strings.description,
                                        text: $addExpenseViewModel.description,
                                        placeholder: "",
                                        textColor: .black,
                                        borderColor: .clear,
                                        icon: "",
                                        iconColor: .black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        CommonTextField(title: Strings.amount,
                                        text: $addExpenseViewModel.amount,
                                        placeholder: "",
                                        textColor: .black,
                                        borderColor: .clear,
                                        icon: "dollarsign.circle",
                                        iconColor: .black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        PickerField(title: Strings.expenseType,
                                    textColor: .black,
                                    borderColor: .clear,
                                    icon: "",
                                    iconColor: .black,
                                    picker: AnyView(Picker("", selection: $addExpenseViewModel.type, content: {
                            ForEach(ExpenseType.allCases, id: \.self) { type in
                                HStack(alignment: .center) {
                                    Image(systemName: type.icon)

                                    Text(type.rawValue)
                                }
                                .tag(type)
                            }
                        })))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)

                        PickerField(title: Strings.card,
                                    textColor: .black,
                                    borderColor: .clear,
                                    icon: "creditcard.circle",
                                    iconColor: .black,
                                    picker: AnyView(Picker("", selection: $addExpenseViewModel.card, content: {
                            ForEach(cardsViewModel.cardsVM, id: \.id) { card in
                                Text(card.name)
                                    .tag(card.id)
                            }
                        })))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .padding([.leading, .trailing])
            }
        }
        .alert(isPresented: $addExpenseViewModel.showError) {
            Alert(title: Text(Strings.Alert.title),
                  message: Text(addExpenseViewModel.errorMessage),
                  dismissButton: .default(Text(Strings.Alert.Button.ok)) { })
        }
        .alert(isPresented: $cardsViewModel.showError) {
            Alert(title: Text(Strings.Alert.title),
                  message: Text(cardsViewModel.errorMessage),
                  dismissButton: .default(Text(Strings.Alert.Button.ok)) { })
        }
    }

    init(cvm: CardsViewModel) {
        self.cardsViewModel = cvm

    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(cvm: CardsViewModel())
    }
}
