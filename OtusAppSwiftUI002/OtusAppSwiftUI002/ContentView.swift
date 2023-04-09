//
//  ContentView.swift
//  OtusAppSwiftUI002
//
//  Created by Александра Наврузова on 03/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabSelection = 0
    @StateObject var favoritesVM = FavoritesViewModel()
    
    var body: some View {
        TabView {
            NewsScreen()
                .tag(0)
                .tabItem {
                    Label("News", systemImage: "list.bullet")
                }
                .environmentObject(favoritesVM)
            FavoritesScreen()
                .tag(1)
                .tabItem {
                    Label("Favotites", systemImage: "star")
                }
                .environmentObject(favoritesVM)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
