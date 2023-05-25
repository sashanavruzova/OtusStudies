//
//  ListArticleCell.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 04/04/2023.
//

import SwiftUI
import Core
import UIDesignSystem

struct ListArticleCell: View {
    let title: String
    let description: String
    let article: Article?
    
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    
    @State private var isHeartSelected: Bool = false
    @State private var isAnimating: Bool = false
    @State private var scaleFactor: CGFloat = 1
    
    private var scaling: CGFloat {
        isAnimating ? 0.5 : scaleFactor
    }
    
    var body: some View {
        
        ArticleCell(action: { },
                    content: {
            HStack {
                NavPushElement(destination: ArticleScreen(article: article)) {
                    Text(title.isEmpty ? description : title)
                        .padding(.trailing, 20)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
                Spacer()
                ZStack {
                    heartImage
                }
            }
        },
                    isAnimating: isAnimating,
                    isSelected: isAnimating)
    }
    
    private var heartImage: some View {
        Image(systemName: isHeartSelected ? "heart.fill" : "heart")
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(self.isHeartSelected ? .red : .gray)
            .scaleEffect(scaling)
            .onTapGesture {
                animateCell()
            }
    }
    
    private func animateCell() {
        withAnimation(Animation.easeIn(duration: 0.5)) {
            self.isHeartSelected.toggle()
            if let article = article {
                if isHeartSelected {
                    self.favoritesVM.addFavorites(article: article)
                } else {
                    self.favoritesVM.removeFavorites(article: article)
                }
                self.isAnimating = true
                self.scaleFactor = 0.5
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isAnimating = false
            self.scaleFactor = 1
        }
    }
}
