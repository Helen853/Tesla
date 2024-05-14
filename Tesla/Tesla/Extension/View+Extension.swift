//
//  View+Extension.swift
//  Tesla

import SwiftUI

extension View {
    func neumorphismUnSelectedStyle() -> some View {
        modifier(NeumorphismUnSelected())
    }
    
    func neumorphismSelectedStyle() -> some View {
        modifier(NeumorphismSelected())
    }
    
    func neumorphismSelectedCircleStyle() -> some View {
        modifier(NeumorphismUnSelectedCircle())
    }
    
    func neumorphismStrokeSelectedCircleStyle() -> some View {
        modifier(NeumorphismStroketSelectedCircle())
    }
    
    func neumorphismStrokeCircle() -> some View {
        modifier(NeumorphismStrokeCircle())
    }
}
