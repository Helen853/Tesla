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
    }
    
    @State var progress = 0.0
    
    var body: some View {
        backgroundStackView {
            VStack {
                topView.padding(.horizontal, 30)
                climateCircle
                Spacer()
                climatePanel
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    private var topView: some View {
        HStack {
            Button {
                print("f")
            } label: {
                Image(Constants.backName)
                    .frame(width: 40, height: 40)
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
                    .frame(width: 40, height: 40)
                    .neumorphismStrokeSelectedCircleStyle()
            }
        }
    }
    
    private var climateCircle: some View {
        ZStack {
            Circle()
                .frame(width: 168, height: 168)
                .overlay {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(Constants.gradientCircleEnd), Color(Constants.gradientCirclestart)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .white.opacity(0.04), radius: 20, x:  -30, y:  -10)
            
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
        }
    }
    
    private var climatePanel: some View {
        VStack {
            makePanel(text: Constants.acText, image: Constants.snowflakeName)
            makePanel(text: Constants.fanText, image: Constants.windName)
            makePanel(text: Constants.heatText, image: Constants.humidityName)
            makePanel(text: Constants.autoText, image: Constants.timerName)

        }
    }
    
    func makePanel(text: String, image: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(.gray)
                .font(.system(size: 17))
            Button {
                print("g")
            } label: {
                Image(systemName: image)
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
                    .neumorphismStrokeSelectedCircleStyle()
            }
            Slider(value: $progress)
                .frame(width: 192)
        }
    }
    
    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
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

struct ClimateView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
            .environment (\.colorScheme, .dark)
    }
}
