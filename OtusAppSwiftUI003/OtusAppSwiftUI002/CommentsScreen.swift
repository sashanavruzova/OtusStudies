//
//  CommentsScreen.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 08/04/2023.
//

import SwiftUI
import UIDesignSystem

struct CommentsScreen: View {
    var body: some View {
        VStack {
            Text("No comments yet")
            
            HStack {
                NavPopElement(destination: .previous) {
                    Text("Back")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                }
                NavPopElement(destination: .root) {
                    Text("Back to news")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.mint)
                }
            }
        }
    }
}

struct CommentsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CommentsScreen()
    }
}
