//
//  Top10View.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 02/07/2023.
//

import SwiftUI

struct Top10View: View {
    @EnvironmentObject var textFieldViewModel: TextFieldViewModel
    
    var body: some View {
        Text(textFieldViewModel.suffixCountSorted)
            .onAppear {
                textFieldViewModel.setTop10Sort()
            }
    }
}
