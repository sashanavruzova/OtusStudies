//
//  ContentView.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 20/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelection = 0
    
    var body: some View {
        TabView {
            TextFieldView(inputWord: .init())
                .tag(0)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SearchHistoryView()
                .tag(1)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
