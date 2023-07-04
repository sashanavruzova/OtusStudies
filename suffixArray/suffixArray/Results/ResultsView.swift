//
//  ResultsView.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 20/06/2023.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var resultsViewModel: ResultsViewModel
    @EnvironmentObject var textFieldViewModel: TextFieldViewModel
    
    @State var buttonTitle = "↑"
    
    var body: some View {
        pickerView
        ScrollView {
            switch resultsViewModel.selectedTab {
            case 0:
                AlphabeticalSortView(buttonTitle: $buttonTitle) {
                    setAlphabeticalSort()
                }
            case 1:
                Top10View()
            default:
                Text("")
            }
        }
    }
    
    var pickerView: some View {
        Picker("Suffixes", selection: $resultsViewModel.selectedTab) {
            Text("All")
                .tag(0)
            Text("Top 10")
                .tag(1)
        }
        .pickerStyle(.segmented)
        .colorMultiply(.teal)
    }
    
    private func setAlphabeticalSort() {
        if buttonTitle == "↑" {
            textFieldViewModel.setAlphabeticalSort(type: .asc)
        } else {
            textFieldViewModel.setAlphabeticalSort(type: .desc)
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
