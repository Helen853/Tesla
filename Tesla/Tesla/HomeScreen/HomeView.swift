//
//  ContentView.swift
//  Tesla

import SwiftUI

struct HomeView: View {
    
    private enum Constants {
        static let startColor = "startColor"
        static let endColor = "endColor"
        static let colorGraundName = "element"
        static let carName = "Tesla"
        static let kmText = "187 km"
        static let batteryName = "battery.75"
        static let personName = "person"
    }
    
    @State var tagSelected = 0
    
    var body: some View {
        backgroundStackView {
            VStack {
                headerView
                carView
                controlPanel
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.startColor), Color(Constants.endColor)], startPoint: .bottom, endPoint: .top)
    }
    
    private var controlPanel: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                if index == 2 {
                    NavigationLink {
                        ClimateView()
                    } label: {
                        Image("\(index)")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .neumorphismSelectedCircleStyle()
                            .overlay {
                                Circle()
                                    .stroke(gradient, lineWidth: 2)
                                    .opacity(tagSelected == index ? 1 : 0)
                            }
                    }
                } else {
                    Button {
                        withAnimation {
                            tagSelected = index
                        }
                    } label: {
                        Image("\(index)")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .neumorphismSelectedCircleStyle()
                            .overlay {
                                Circle()
                                    .stroke(gradient, lineWidth: 2)
                                    .opacity(tagSelected == index ? 1 : 0)
                            }
                    }
                }
            }
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 50).fill(Color(Constants.colorGraundName))
            )
            .neumorphismUnSelectedStyle()
    }
    
    private var carView: some View {
        Image("car")
            .resizable()
            .frame(width: 314.5, height: 198.5)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constants.carName)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                HStack {
                    Image(systemName: Constants.batteryName)
                        .foregroundColor(.gray)
                    Text(Constants.kmText)
                        .font(.system(size: 17, weight: .semibold))
                        .opacity(0.4)
                }
                
            }
            Spacer()
            Image(Constants.personName)
                .resizable(resizingMode: .stretch)
                .foregroundColor(.gray)
                .frame(width: 35, height: 35)
                .neumorphismStrokeSelectedCircleStyle()
        }.padding(.all, 25)
    }
    
    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(Constants.colorGraundName))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment (\.colorScheme, .dark)
    }
}
