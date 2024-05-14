//
//  SelectedViewModifier.swift
//  Tesla

import SwiftUI

struct NeumorphismUnSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("light"), radius: 5, x: -5, y: -5)
            .shadow(color: Color("dark"), radius: 5, x: 5, y: 5)
    }
}

struct NeumorphismSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("light"), radius: 5, x: 5, y: 5)
            .shadow(color: Color("dark"), radius: 5, x: -5, y: -5)
    }
}

struct NeumorphismUnSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .shadow(color: Color("light"), radius: 5, x: 10, y: 10)
            .shadow(color: Color("dark"), radius: 5, x: -5, y: -5)
    }
}

struct NeumorphismStroketSelectedCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(15)
            .background {
                ZStack {
                    RadialGradient(
                        colors: [Color("dark").opacity(0.35), .clear],
                        center: .top,
                        startRadius: 40,
                        endRadius: 20)
                    Circle()
                        .fill(LinearGradient(
                            stops: [
                                .init(color: Color("light"), location: 0.2),
                                .init(color: Color("dark"), location: 0.7)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                              )
                        .padding(2)
                        .neumorphismUnSelectedStyle()
                        
                    Circle()
                        .stroke(LinearGradient(
                            colors: [Color("dark"), Color("light")],
                            startPoint: .top,
                            endPoint: .bottomTrailing), lineWidth: 2)
                }
            }.clipShape(Circle())
            
            .shadow(color: Color("dark"), radius: 7, x: 10, y: 10)
            .shadow(color: Color("light"), radius: 7, x: -10, y: -10)
            
    }
}

struct NeumorphismStrokeCircle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .overlay {
                Circle()
                    .stroke(Color("dark"), lineWidth: 1.5)
            }
            .background(
                Circle()
                    .fill(Color("element"))
            )
            .shadow(color: Color("light"), radius: 5, x: -10, y: -10)
            
    }
}
