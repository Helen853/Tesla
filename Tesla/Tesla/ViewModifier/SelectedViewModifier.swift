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
                                .init(color: Color("startRadial"), location: 0.2),
                                .init(color: Color("dark"), location: 0.7)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                              )
                        .padding(2)
                        .neumorphismUnSelectedStyle()
                    Circle()
                        .stroke(LinearGradient(
                            colors: [Color("dark"), Color("startRadial")],
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

struct NeumorphismBlueButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(15)
            .background {
                ZStack {
                    RadialGradient(
                        colors: [Color("darkBlueButton").opacity(0.35), .clear],
                        center: .top,
                        startRadius: 40,
                        endRadius: 20)
                    Circle()
                        .fill(LinearGradient(
                            stops: [
                                .init(color: Color("lightBlueButton"), location: 0.2),
                                .init(color: Color("darkBlueButton"), location: 0.7)
                            ],
                            startPoint: .bottomTrailing,
                            endPoint: .topLeading)
                              )
                        .padding(2)
                        .neumorphismUnSelectedStyle()
                    Circle()
                        .stroke(LinearGradient(
                            colors: [Color("darkBlueButton"), Color("lightBlueButton")],
                            startPoint: .top,
                            endPoint: .bottomTrailing), lineWidth: 2)
                }
            }.clipShape(Circle())
    }
}

struct NeumorphismCapsuleBlueButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(15)
            .background {
                ZStack {
                    RadialGradient(
                        colors: [Color("darkBlueButton").opacity(0.35), .clear],
                        center: .top,
                        startRadius: 40,
                        endRadius: 20)
                    Capsule()
                        .fill(LinearGradient(
                            stops: [
                                .init(color: Color("lightBlueButton"), location: 0.2),
                                .init(color: Color("darkBlueButton"), location: 0.7)
                            ],
                            startPoint: .bottomTrailing,
                            endPoint: .topLeading)
                              )
                        .padding(2)
                        .neumorphismUnSelectedStyle()
                    Capsule()
                        .stroke(LinearGradient(
                            colors: [Color("darkBlueButton"), Color("lightBlueButton")],
                            startPoint: .top,
                            endPoint: .bottomTrailing), lineWidth: 2)
                }
            }.clipShape(Capsule())
    }
}

struct NeumorphismBattery: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    RadialGradient(
                        colors: [Color("dark").opacity(0.35), .clear],
                        center: .top,
                        startRadius: 40,
                        endRadius: 20)
                    BatteryView()
                        .fill(LinearGradient(
                            stops: [
                                .init(color: Color("startRadial"), location: 0.2),
                                .init(color: Color("light"), location: 0.7)
                            ],
                            startPoint: .top,
                            endPoint: .bottom)
                        )
                        .padding(2)
                        .neumorphismUnSelectedStyle()
                    BatteryView()
                        .stroke(LinearGradient(
                            colors: [Color("dark"), Color("startRadial")],
                            startPoint: .top,
                            endPoint: .bottomTrailing), lineWidth: 2)
                }
            }.clipShape(BatteryView())
            .shadow(color: Color("dark"), radius: 7, x: 10, y: 10)
            .shadow(color: Color("light"), radius: 7, x: -10, y: -10)
    }
}

struct NeumorphismRectangle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                    RoundedRectangle(cornerRadius: 35)
                        .stroke(Color.gray, lineWidth: 10)
                        .shadow(color: .black.opacity(0.8), radius: 6, x: 6, y: 6)
                        .shadow(color: .white.opacity(0.1), radius: 5, x: -5, y: -5)
                        .clipShape(RoundedRectangle(cornerRadius: 35).inset(by: 5.1))

            }
            
    }
}

