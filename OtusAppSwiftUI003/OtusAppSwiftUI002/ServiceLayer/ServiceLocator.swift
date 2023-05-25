//
//  ServiceLocator.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 14/04/2023.
//

import Foundation

protocol ServiceLocatorProtocol {
    func resolve<T>() -> T?
}

final class ServiceLocator: ServiceLocatorProtocol {
    public static let shared = ServiceLocator()
    
    private lazy var services: [String: Any] = [:]
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    func register<T>(service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }
    
    func resolve<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
