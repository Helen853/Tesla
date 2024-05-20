//
//  ClimateView.swift
//  Tesla

import SwiftUI

struct ClimateView: View {
    
    private enum Constants {
        static let startColor = "startColor"
        static let endColor = "endColor"
        static let colorGraundName = "element"
        static let title = "CLIMATE"
        static let backName = "back"
        static let settingsName = "gearshape"
        static let gradientCirclestart = "gradientCirclestart"
        static let gradientCircleEnd = "gradientCircleEnd"
        static let snowflakeName = "snowflake"
        static let windName = "wind"
        static let humidityName = "humidity"
        static let timerName = "timer"
        static let acText = "Ac"
        static let fanText = "Fan"
        static let heatText = "Heat"
        static let autoText = "Auto"
        static let sliderName = "Knob"
        static let bottomSheetColor = "bottomSheetColor"
        static let alertTitle = "Tesla Support"
        static let linkUrlText = "https://www.tesla.com/support"
        static let cancelAlert = "Cancel"
        static let linkText = "Перейти по ссылке"
        static let alertColorName = "darkBlueButton"
    }
    
    @Environment(\.presentationMode) var presentatin
    
    var body: some View {
        ZStack {
            backgroundStackView {
                VStack {
                    topView.padding(.horizontal, 30)
                    Spacer()
                        .frame(height: 70)
                    climateCircle
                    Spacer()
                        .frame(height: 130)
                    climatePanel
                }
            }.blur(radius: showAlert ? 10 : 0)
            bottomSheet
            if showAlert {
                linkAlert
                    .transition(.zoomAsymInOut)
                    .zIndex(1)
            }
        }.ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
    }
    
    @ObservedObject private var viewModel = ClimateViewModel()
    
    @GestureState private var gestureOffset = CGSize.zero
    
    @State private var currentMenuOffsetY: CGFloat = 0.0
    @State private var lastMenuOffsetY: CGFloat = 0.0
    @State private var progress: Float = 0.0
    @State private var progressTemperature: Float = 0.0
    @State private var showPahel = true
    @State private var isSElectedButton = false
    @State private var showTemperature = false
    @State private var currentTemperature = 15
    @State private var selectedColor = Color.blue
    @State private var range: ClosedRange<Float> = 15.0...30.0
    @State private var showAlert = false
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { value in
                let maxHeight = UIScreen.main.bounds.height - 100
                withAnimation {
                    if -currentMenuOffsetY > maxHeight / 5 {
                        currentMenuOffsetY = -maxHeight + 650
                    } else {
                        currentMenuOffsetY = 0
                    }
                    lastMenuOffsetY = currentMenuOffsetY
                }
            }
    }
    
    private var bottomSheet: some View {
        BottomSheet(viewModel: viewModel, selectedColor: $selectedColor, currentProgress: $progressTemperature)
        .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height + 300)
        .background(
            RoundedRectangle(cornerRadius: 40).fill(Color(Constants.bottomSheetColor).opacity(0.9))
        )
        .ignoresSafeArea(.all, edges: .bottom)
        .offset(y: UIScreen.main.bounds.height)
        .offset(y: currentMenuOffsetY)
        .gesture(dragGesture)
        .blur(radius: showAlert ? 10 : 0)
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
                withAnimation {
                    showAlert.toggle()
                }
            } label: {
                Image(systemName: Constants.settingsName)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .neumorphismStrokeSelectedCircleStyle()
            }
        }
    }
    
    private var climateCircle: some View {
        ZStack {
            Circle()
                .frame(width: 168.2, height: 168.2)
                .overlay {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(Constants.gradientCircleEnd), Color(Constants.gradientCirclestart)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                    Circle()
                        .trim(from: 0, to: (Double(progressTemperature) - 15) / 15)
                        .stroke(selectedColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .shadow(color: selectedColor, radius: 20)
                }
                .shadow(color: Color("endColor").opacity(0.04), radius: 30, x:  -50, y:  -10)
            Circle()
                .frame(width: 119, height: 119)
                .overlay {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(Constants.gradientCirclestart), Color(Constants.gradientCircleEnd)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                }
            Text(viewModel.showTemperature ? ("\(Int(progressTemperature)) ° C") : " ")
                .font(.system(size: 28, weight: .bold))
        }
    }
    
    private var climatePanel: some View {
        DisclosureGroup(" ", isExpanded: $showPahel) {
            VStack {
                temperaturePanel
                .padding(.leading, 40)
                makePanel(text: Constants.fanText, image: Constants.windName)
                makePanel(text: Constants.heatText, image: Constants.humidityName)
                makePanel(text: Constants.autoText, image: Constants.timerName)
            }
        }.padding()
    }
    
    private var temperaturePanel: some View {
        HStack {
            Text(Constants.acText)
                .foregroundColor(.gray)
                .font(.system(size: 17))
                .frame(alignment: .leading)
            Spacer()
            Button {
                isSElectedButton.toggle()
            } label: {
                Image(systemName: Constants.snowflakeName)
                    .foregroundColor(viewModel.showTemperature ? .blue : .gray)
                    .frame(width: 20, height: 20)
                    .neumorphismStrokeSelectedCircleStyle()
            }
            Spacer()
                .frame(width: 16)
            CustomSlider(firstValue: $progressTemperature, range: range, color: selectedColor, nameImage: Constants.sliderName)
                .frame(width: 192)
        }
    }
    
    private var linkAlert: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(Constants.alertColorName))
                .frame(width: 250, height: 170)
                .shadow(radius: 2)
            VStack(spacing: 5) {
                Text(Constants.alertTitle)
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                if let url = URL(string: Constants.linkUrlText) {
                    Link(Constants.linkText, destination: url)
                        .foregroundColor(.white)
                }
                Spacer()
                    .frame(height: 10)
                linkButton
                .padding(.horizontal, 120)
            }
        }
    }
    
    private var linkButton: some View {
        Button {
            withAnimation {
                showAlert = false
            }
        } label: {
            ZStack {
                Text(Constants.cancelAlert)
                    .foregroundColor(Color(uiColor: .white))
                    .font(.system(size: 20))
                    .frame(width: 100)
                    .neumorphismCapsuleBlueButton()
            }
        }
    }
    
    private func makePanel(text: String, image: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(.gray)
                .font(.system(size: 17))
                .frame(alignment: .leading)
            Spacer()
            Button {
                print("g")
            } label: {
                Image(systemName: image)
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
                    .neumorphismStrokeSelectedCircleStyle()
            }
            Spacer()
                .frame(width: 15)
            CustomSlider(firstValue: $progress, range: range, color: selectedColor, nameImage: Constants.sliderName)
                .frame(width: 192)
        }.padding(.leading, 40)
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
    
    private func onChangeMenuOffset() {
        Task {
            await MainActor.run(body: {
                self.currentMenuOffsetY = gestureOffset.height + lastMenuOffsetY
            })
        }
    }
}

struct ClimateView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment (\.colorScheme, .dark)
    }
}
