//
//  suffixArrayApp.swift
//  suffixArray
//
//  Created by Aleksandra Navruzova on 20/06/2023.
//

import SwiftUI

@main
struct suffixArrayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TextFieldViewModel())
                .environmentObject(ResultsViewModel())
        }
    }
}
