//
//  ServiceLocator.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 14/04/2023.
//

import Foundation

protocol ServiceLocatorProtocol {
    func getService<T>() -> T?
}
final public class ServiceLocator: ServiceLocatorProtocol {
    static let shared = ServiceLocator()
    
    private lazy var services: [String: Any] = [:]
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    func addService<T>(service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
