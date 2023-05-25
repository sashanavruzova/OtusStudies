//
//  Configurator.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 14/04/2023.
//

import Foundation

class Configurator {
    static let shared = Configurator()
    
    private init() {}
    
    func setup() {
        setUpNewsService()
    }
    
    private func setUpNewsService() {
        let newsService: NewsServiceProtocol = NewsService()
        ServiceLocator.shared.register(service: newsService)
    }
}
