//
//  SearchHistoryView.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 17/07/2023.
//

import SwiftUI

struct SearchHistoryView: View {
    @EnvironmentObject var searchHistoryView: TextFieldViewModel
    
    var body: some View {
        List {
            ForEach(searchHistoryView.searchHistory, id: \.self) { text in
                Text(text)
            }
        }
    }
}

