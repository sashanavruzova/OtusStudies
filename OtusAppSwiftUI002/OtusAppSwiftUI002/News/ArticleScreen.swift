//
//  ArticleScreen.swift
//  OtusAppSwiftUI002
//
//  Created by Александра Наврузова on 08/04/2023.
//

import SwiftUI
import Networking
import UIDesignSystem

struct ArticleScreen: View {
    
    let article: Article?
    
    var body: some View {
        ScrollView {
            Text(article?.content ?? "")
                .font(.system(size: 16))
                .padding()
        }
        
        HStack {
            NavPopElement(destination: .previous) {
                Text("Back")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
            }
            NavPushElement(destination: CommentsScreen()) {
                Text("Comments")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.mint)
            }
        }
    }
}

//struct ArticleScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleScreen(article: "Test")
//    }
//}
