//
//  BatteryPath.swift
//  Tesla


import SwiftUI

struct BatteryView: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.61205*height))
        path.addLine(to: CGPoint(x: 0, y: 0.94872*height))
        path.addCurve(to: CGPoint(x: 0.01307*width, y: height), control1: CGPoint(x: 0, y: 0.97704*height), control2: CGPoint(x: 0.00585*width, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width, y: 0.61155*height))
        path.addCurve(to: CGPoint(x: 0.99922*width, y: 0.59411*height), control1: CGPoint(x: width, y: 0.60561*height), control2: CGPoint(x: 0.99974*width, y: 0.5997*height))
        path.addLine(to: CGPoint(x: 0.94756*width, y: 0.03384*height))
        path.addCurve(to: CGPoint(x: 0.93527*width, y: 0), control1: CGPoint(x: 0.94569*width, y: 0.01353*height), control2: CGPoint(x: 0.94078*width, y: 0))
        path.addLine(to: CGPoint(x: 0.06782*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.05561*width, y: 0.03294*height), control1: CGPoint(x: 0.0624*width, y: 0), control2: CGPoint(x: 0.05754*width, y: 0.0131*height))
        path.addLine(to: CGPoint(x: 0.00086*width, y: 0.59371*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.61205*height), control1: CGPoint(x: 0.00029*width, y: 0.59956*height), control2: CGPoint(x: 0, y: 0.60578*height))
        path.closeSubpath()
        
        return path
    }
}
