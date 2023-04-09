//
//  NewsScreen.swift
//  OtusAppSwiftUI002
//
//  Created by Александра Наврузова on 03/04/2023.
//

import SwiftUI
import Networking
import UIDesignSystem

enum NewsSections {
    case world
    case israel
    case russia
}

struct NewsScreen: View {
    
    @StateObject var newsVM: NewsViewModel = .init()
    @State var headerVariant = 0
    var headers = ["World News", "Israel", "Russia"]
    
    var body: some View {
        NavigationStackView(transition: .custom(AnyTransition.moveAndFade)) {
            VStack {
                Picker("Headers", selection: $headerVariant) {
                    ForEach(0..<headers.count, id: \.self) { index in
                        Text(self.headers[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: headerVariant) { newValue in
                    switch newValue {
                    case 0:
                        newsVM.getNews(section: .world)
                    case 1:
                        newsVM.getNews(section: .israel)
                    case 2:
                        newsVM.getNews(section: .russia)
                    default:
                        break
                    }
                }
                list
            }
        }
    }
    
    var list: some View {
        List(newsVM.articles, id: \.self) { article in
            ListArticleCell(title: article.title ?? "", description: article.description ?? "", article: article)
        }
        .listStyle(PlainListStyle())
    }
}

struct NewsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
