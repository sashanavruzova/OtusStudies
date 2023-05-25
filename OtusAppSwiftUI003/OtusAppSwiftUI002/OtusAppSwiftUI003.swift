//
//  OtusAppSwiftUI003.swift
//
//  Created by Aleksandra Navruzova on 03/04/2023.
//

import SwiftUI

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
