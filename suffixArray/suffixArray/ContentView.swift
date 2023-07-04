//
//  ContentView.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 20/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TextFieldView(inputWord: .init())
            ResultsView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
