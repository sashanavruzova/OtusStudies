//
//  Injected.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 22/04/2023.
//

import Foundation

@propertyWrapper
struct Injected<Service> {
    private var service: Service?
    
    public var wrappedValue: Service? {
        mutating get {
            if service == nil {
                service = ServiceLocator.shared.resolve()
            }
            return service
        }
    }
    
    public var projectedValue: Injected<Service> {
        mutating set {
            self = newValue
        }
        get {
            return self
        }
    }
}
