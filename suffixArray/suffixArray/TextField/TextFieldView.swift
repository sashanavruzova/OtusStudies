//
//  TextFieldView.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 20/06/2023.
//

import SwiftUI

struct TextFieldView: View {
    @EnvironmentObject var viewModel: TextFieldViewModel
    
    @State var inputWord: String = .init()
    
    var body: some View {
        VStack {
            textField
                .lineLimit(100)
                .onSubmit {
                    submitAction()
                }
            ResultsView()
        }
        .padding()
    }
    
    var textField: some View {
        TextField("Enter a word", text: $inputWord, axis: .vertical)
            .truncationMode(.tail)
            .autocapitalization(.none)
            .padding()
            .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.teal, lineWidth: 1)
                )
            .padding()
    }
    
    private func submitAction() {
        viewModel.fillHistoryList(text: inputWord)
        Task {
            await viewModel.countSuffixesFrom(text: inputWord)
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView()
    }
}
