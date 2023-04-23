//
//  AnyTransition.swift
//  
//
//  Created by Aleksandra Navruzova on 08/04/2023.
//

import SwiftUI

public extension AnyTransition {
    
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
