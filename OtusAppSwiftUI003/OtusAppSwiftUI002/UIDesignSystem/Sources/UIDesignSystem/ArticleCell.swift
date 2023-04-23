//
//  ArticleCell.swift
//  
//
//  Created by Aleksandra Navruzova on 09/04/2023.
//

import SwiftUI

public struct ArticleCell<Content: View>: View {
    
    private var action: () -> Void
    private var content: () -> Content
    private var isAnimating: Bool
    private var isSelected: Bool
    
    @State private var scaleFactor: CGFloat = 1
    
    private var scaling: CGFloat {
        isAnimating ? 0.5 : scaleFactor
    }
    
    private var offset: CGSize {
        isAnimating ? CGSize(width: UIScreen.main.bounds.width - 50,
                             height: UIScreen.main.bounds.height - 100) : .zero
    }
    
    public init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content, isAnimating: Bool, isSelected: Bool) {
        self.action = action
        self.content = content
        self.isAnimating = isAnimating
        self.isSelected = isSelected
    }
    
    public var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .leading) {
                self.content()
            }
            .scaleEffect(scaleFactor)
            .offset(offset)
        }
        .zIndex(isSelected ? 1 : 0)
    }
}
