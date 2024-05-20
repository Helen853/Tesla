//
//  BottomSheet.swift
//  Tesla


import SwiftUI

struct BottomSheet: View {
    
    private enum Constants {
        static let title = "A/C is"
        static let tapText = "Tap to turn off or swipe up\n for a fast setup"
        static let onText = "On"
        static let OffText = "Off"
        static let ventText = "Vent"
        static let chevronLeft = "chevron.left"
        static let chevronRight = "chevron.right"
        static let imageName = "Union"
    }
    
    @ObservedObject var viewModel: ClimateViewModel
    
    @Binding var selectedColor: Color
    @Binding var currentProgress: Float
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 100, height: 2)
                .foregroundColor(.black)
            HStack {
                descriptionView
                Spacer()
                onButton
            }.padding()
            colorPanel
                .padding(.horizontal, 35)
            HStack {
                Text(Constants.onText)
                Spacer()
                Text(Constants.ventText)
            }.foregroundColor(.gray)
                .padding()
            Spacer()
        }.padding()
    }
    
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(Constants.title) \(viewModel.showTemperature ? Constants.OffText : Constants.onText)")
                .bold()
                .foregroundColor(.white)
            Text(Constants.tapText)
                .foregroundColor(.gray)
        }
    }
    
    private var onButton: some View {
        Button {
            withAnimation(.linear(duration: 0.3).delay(0.3)) {
                viewModel.showTemperature.toggle()
                currentProgress = 15.0
            }
        } label: {
            Image(Constants.onText)
                .foregroundColor(.white)
                .neumorphismBlueButton()
        }
    }
    
    private var colorPanel: some View {
        HStack {
            ColorPicker(selection: $selectedColor, supportsOpacity: true) {}
                .frame(width: 20)
            Spacer()
            leftButton
            Spacer()
                .frame(width: 25)
            Text("\(Int(currentProgress)) °")
                .bold()
                .font(.system(size: 28))
                .frame(width: 60, alignment: .center)
            rightButton
            Spacer()
            Image(Constants.imageName)
        }
    }
    
    private var leftButton: some View {
        Button {
            withAnimation(.linear) {
                viewModel.currentTemperature = currentProgress
                viewModel.reduceTemperature()
                currentProgress = viewModel.currentTemperature
            }
        } label: {
            Image(systemName: Constants.chevronLeft)
                .foregroundColor(.gray)
        }
    }
    
    private var rightButton: some View {
        Button {
            withAnimation(.linear) {
                viewModel.currentTemperature = currentProgress
                viewModel.addTemperature()
                currentProgress = viewModel.currentTemperature
            }
        } label: {
            Image(systemName: Constants.chevronRight)
                .foregroundColor(.gray)
        }
    }
}

