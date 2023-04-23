//
//  OtusAppSwiftUI003.swift
//  OtusAppSwiftUI002
//
//  Created by Aleksandra Navruzova on 03/04/2023.
//

import SwiftUI
import Core

@main
struct OtusAppSwiftUI003: App {
    
    init() {
        Configurator.shared.setup()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
