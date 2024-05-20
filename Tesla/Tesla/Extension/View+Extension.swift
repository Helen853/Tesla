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
    
    func neumorphismBlueButton() -> some View {
        modifier(NeumorphismBlueButton())
    }
    
    func myTabItem(_ label: () -> TabItem) -> some View {
        modifier(TabItemModifire(tabBarItem: label()))
    }
    
    func neumorphismCapsuleBlueButton() -> some View {
        modifier(NeumorphismCapsuleBlueButton())
    }
    
    func neumorphismBattery() -> some View {
        modifier(NeumorphismBattery())
    }
    
    func neumorphismRectangle() -> some View {
        modifier(NeumorphismRectangle())
    }
}
