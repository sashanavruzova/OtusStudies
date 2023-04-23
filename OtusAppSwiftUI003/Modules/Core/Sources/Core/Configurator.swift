//
//  Configurator.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 14/04/2023.
//

import Foundation

public class Configurator {
    public static let shared = Configurator()
    
    private init() {}
    
    public func setup() {
        setUpNewsService()
    }
    
    private func setUpNewsService() {
        let newsService: NewsServiceProtocol = NewsService()
        ServiceLocator.shared.addService(service: newsService)
    }
}
