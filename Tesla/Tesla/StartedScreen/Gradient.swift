//
//  Gradient.swift
//  Tesla

import SwiftUI

struct Gradient: View {
    
    private enum Constants {
        static let startColor = "startColor"
        static let endColor = "endColor"
    }
    var body: some View {
        gradient
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.startColor), Color(Constants.endColor)], startPoint: .bottom, endPoint: .top)
    }
}
