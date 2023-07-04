//
//  AlphabeticalSortView.swift
//  suffixArray
//
//  Created by Александра Наврузова on 02/07/2023.
//

import SwiftUI

struct AlphabeticalSortView: View {
    @EnvironmentObject var textFieldViewModel: TextFieldViewModel
    @Binding var buttonTitle: String
    var setAlphabeticalSort: () -> Void
    
    var body: some View {
        sortingButton
        Text(textFieldViewModel.suffixCountSorted)
            .onAppear {
                setAlphabeticalSort()
            }
    }
    
    var sortingButton: some View {
        Button("Sort \(buttonTitle)") {
            toggleButtonTitle()
            setAlphabeticalSort()
        }
        .padding()
        .background(Color(.systemTeal))
        .foregroundColor(.white)
        .cornerRadius(5)
    }
    
    private func toggleButtonTitle() {
        buttonTitle = buttonTitle == "↑" ? "↓" : "↑"
    }
}
