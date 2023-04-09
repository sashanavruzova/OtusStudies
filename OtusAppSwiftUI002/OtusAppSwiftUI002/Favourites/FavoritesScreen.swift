//
//  FavoritesScreen.swift
//  OtusAppSwiftUI002
//
//  Created by Александра Наврузова on 03/04/2023.
//

import SwiftUI
import UIDesignSystem

struct FavoritesScreen: View {
    
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    
    var body: some View {
        NavigationStackView(transition: .none, content: {
            List(favoritesVM.favoritesArticles, id: \.self) { article in
                Text(article.title ?? "")
            }
            .listStyle(PlainListStyle())
        })
    }
}
