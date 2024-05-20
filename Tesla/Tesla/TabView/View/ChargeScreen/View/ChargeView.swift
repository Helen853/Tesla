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
        static let carName = "carBattery"
        static let sliderName = "angle"
        static let setText = "Set chardge limit"
        static let sevenPersent = "75%"
        static let hundredPersent = "100%"
        static let startColor = "startColor"
        static let endColor = "endColor"
        static let panelTitle = "Nearby Superchargers"
        static let arrowName = "chevron.up"
    }
    
    @Environment(\.presentationMode) var presentatin
    
    var body: some View {
        backgroundStackView {
            ZStack {
                shadowView
                    .offset(x: -150, y: 30)
                VStack {
                    topView.padding(.horizontal, 30)
                    Image(Constants.carName)
                    chargeText
                    batteryView
                    persentView
                    chargeSlider
                    Text(Constants.setText)
                        .foregroundColor(.gray)
                    panelView
                    Spacer()
                }
            }
        }
    }
    
    @ObservedObject private var viewModel = ChargeViewModel()
    
    @State private var progress: Float = 62.0
    @State private var selectedColor = Color.clear
    @State private var range: ClosedRange<Float> = 0.0...100.0
    @State private var isOpasitySeven = false
    @State private var isOpasityHundred = false
    
    private var shadowView: some View {
        Circle()
            .fill(gradient)
            .frame(width: 308, height: 314)
            .opacity(0.09)
            .blur(radius: 60)
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
    
    private var chargeText: some View {
        HStack(spacing: 0) {
            Text("\(Int(progress.magnitude))")
                .font(.system(size: 35, weight: .bold))
            Text("%")
                .foregroundColor(.gray)
                .font(.system(size: 20))
                .offset(y: 5)
        }
    }
    
    private var batteryView: some View {
        ZStack(alignment: .leading) {
            BatteryView()
                .frame(width: 271, height: 45)
                .neumorphismBattery()
                .overlay {
                    BatteryView()
                        .fill(gradient)
                        .mask {
                            GeometryReader { proxy in
                                BatteryView()
                                    .frame(width: proxy.size.width * Double(progress/100), height: 45)
                            }
                        }
                }
            Rectangle()
                .fill(gradient.opacity(0.1))
                .frame(width: Double(progress * 2.7), height: 97)
                .blur(radius: 4)
                .offset(y: -20)
        }
    }
    
    private var persentView: some View {
        HStack {
            Spacer()
            makepersentView(text: Constants.sevenPersent, isOpasity: isOpasitySeven)
            if progress >= 75.0 {
            }
            Spacer()
                .frame(width: 40)
            makepersentView(text: Constants.hundredPersent, isOpasity: isOpasityHundred)
        }.padding(.trailing, 42)
    }
    
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.startColor), Color(Constants.endColor)], startPoint: .top, endPoint: .bottom)
    }
    
    private var chargeSlider: some View {
        CustomSlider(firstValue: $progress, range: range, color: selectedColor, nameImage: Constants.sliderName)
            .frame(width: 273)
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onEnded { value in
                withAnimation {
                    if progress > 75.0 {
                        isOpasitySeven = true
                    }
                    if progress == 100.0 {
                        isOpasityHundred = true
                    }
                }
            }
    }
    
    private var panelView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.clear)
                .frame(width: 338, height: 130)
                .neumorphismRectangle()
            HStack {
                Text(Constants.panelTitle)
                    .font(.system(size: 20, weight: .bold))
                Image(systemName: Constants.arrowName)
                    .frame(width: 30, height: 30)
                    .neumorphismStrokeSelectedCircleStyle()
            }
        }
    }
    
    private func makepersentView(text: String, isOpasity: Bool) -> some View {
        VStack {
            Rectangle()
                .fill(gradient)
                .frame(width: 1, height: 9)
            Text(text)
                .font(.system(size: 13))
                .offset(x: -12)
                .opacity(isOpasity ? 1 : 0.5)
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

struct ChargeView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeView()
            .environment (\.colorScheme, .dark)
    }
}
