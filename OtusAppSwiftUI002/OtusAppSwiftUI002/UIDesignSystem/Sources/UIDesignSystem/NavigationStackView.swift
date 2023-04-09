//
//  NavigationStackView.swift
//  
//
//  Created by Александра Наврузова on 03/04/2023.
//

import SwiftUI

final public class NavigationStackViewModel: ObservableObject {
    
    var easing: Animation = .easeInOut(duration: 0.5)
    
    var navigationType: NavType = .push
    
    @Published fileprivate var current: Screen?
    private var screenStack = ScreenStack() {
        didSet {
            current = screenStack.top()
        }
    }
    
    // MARK: - API
    
    func push<S: View>(_ screen: S) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString,
                                nextScreen: AnyView(screen))
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination = .previous) {
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .previous:
                screenStack.popToPrevious()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
    
}

public struct NavigationStackView<Content>: View where Content: View {

    @StateObject var viewModel: NavigationStackViewModel = .init()
    
    private let content: Content
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    public var easing: Animation {
        get {
            viewModel.easing
        }
        set {
            viewModel.easing = newValue
        }
    }
    
    public init(transition: NavTransition,
                easing: Animation = .easeInOut(duration: 0.33),
                @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        switch transition {
        case .custom(let t):
            self.transitions = (t, t)
        case .none:
            self.transitions = (.identity, .identity)
        }
    }
    
    public var body: some View {
        let isRoot = viewModel.current == nil
        return ZStack {
            if isRoot {
                content
                    .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                    .environmentObject(viewModel)
            } else {
                viewModel.current!.nextScreen
                    .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                    .environmentObject(viewModel)
            }
        }
        
    }
    
}

public struct NavPushElement<Content, Destination>: View where Content: View, Destination :View {
    
    @EnvironmentObject var viewModel: NavigationStackViewModel
    
    private let destination: Destination
    private let content: Content
    
    public init(destination: Destination, @ViewBuilder content: @escaping ()->Content) {
        self.destination = destination
        self.content = content()
    }
    
    public var body: some View {
        content.onTapGesture {
            push()
        }
    }
    
    private func push() {
        viewModel.push(destination)
    }
    
}

public struct NavPopElement<Content>: View where Content: View {
    
    @EnvironmentObject var viewModel: NavigationStackViewModel
    
    private let destination: PopDestination
    private let content: Content
    
    public init(destination: PopDestination, @ViewBuilder content: @escaping ()->Content) {
        self.destination = destination
        self.content = content()
    }
    
    public var body: some View {
        content.onTapGesture {
            pop()
        }
    }
    
    private func pop() {
        viewModel.pop(to: destination)
    }
    
}

// MARK: - Enums

public enum NavTransition {
    case none
    case custom(AnyTransition)
}

enum NavType {
    case push
    case pop
    case byId
}

public enum PopDestination {
    case previous
    case root
}

// MARK: - Base Logic

private struct Screen: Identifiable, Equatable {

    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
    
}

private struct ScreenStack {
    
    private var screens: [Screen] = .init()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func pushToId(id: String) {
        debugPrint("pushToId \(id)")
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
    
}
