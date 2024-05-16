//
//  TabPath.swift
//  Tesla

import SwiftUI

struct TabBar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.63077 * height))
        path.addLine(to: CGPoint(x: 0.04192 * width, y: 0.49954 * height))
        path.addCurve(to: CGPoint(x: 0.11967 * width, y: 0.4 * height), control1: CGPoint(x: 0.06223 * width, y: 0.43595 * height), control2: CGPoint(x: 0.09032 * width, y: 0.4 * height))
        path.addLine(to: CGPoint(x: 0.31879 * width, y: 0.4 * height))
        path.addCurve(to: CGPoint(x: 0.38029 * width, y: 0.45786 * height), control1: CGPoint(x: 0.34078 * width, y: 0.4 * height), control2: CGPoint(x: 0.36224 * width, y: 0.42019 * height))
        path.addLine(to: CGPoint(x: 0.43411 * width, y: 0.57018 * height))
        path.addCurve(to: CGPoint(x: 0.56589 * width, y: 0.57018 * height), control1: CGPoint(x: 0.47372 * width, y: 0.65284 * height), control2: CGPoint(x: 0.52628 * width, y: 0.65284 * height))
        path.addLine(to: CGPoint(x: 0.61971 * width, y: 0.45786 * height))
        path.addCurve(to: CGPoint(x: 0.68121 * width, y: 0.4 * height), control1: CGPoint(x: 0.63776 * width, y: 0.42019 * height), control2: CGPoint(x: 0.65922 * width, y: 0.4*height))
        path.addLine(to: CGPoint(x: 0.88033*width, y: 0.4*height))
        path.addCurve(to: CGPoint(x: 0.95808*width, y: 0.49954*height), control1: CGPoint(x: 0.90968 * width, y: 0.4 * height), control2: CGPoint(x: 0.93777 * width, y: 0.43595*height))
        path.addLine(to: CGPoint(x: width, y: 0.63077 * height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: 0.63077 * height))
        path.closeSubpath()
        return path
    }
}
