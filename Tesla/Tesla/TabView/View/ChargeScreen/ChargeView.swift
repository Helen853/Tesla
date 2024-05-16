//
//  ChargeView.swift
//  Tesla

import SwiftUI

struct ChargeView: View {
    
    private enum Constants {
        static let title = "CHARGING"
        static let backName = "back"
        static let settingsName = "gearshape"
        static let colorGraundName = "element"
    }
    
    @Environment(\.presentationMode) var presentatin
    
    var body: some View {
        backgroundStackView {
            VStack {
                topView.padding(.horizontal, 30)
                Spacer()
            }
        }
    }
    
    private var topView: some View {
        HStack {
            Button {
                presentatin.wrappedValue.dismiss()
            } label: {
                Image(Constants.backName)
                    .frame(width: 30, height: 30)
                    .neumorphismStrokeSelectedCircleStyle()
            }
            Spacer()
            Text(Constants.title)
                .font(.system(size: 20, weight: .semibold))
            Spacer()
            
            Button {
                print("f")
            } label: {
                Image(systemName: Constants.settingsName)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .neumorphismStrokeSelectedCircleStyle()
            }
        }
    }
    
    private func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    Color(Constants.colorGraundName)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}
