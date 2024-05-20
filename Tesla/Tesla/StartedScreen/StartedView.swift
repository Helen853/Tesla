//
//  StartedView.swift
//  Tesla

import SwiftUI

struct StartedView: View {
    
    private enum Constants {
        static let startColor = "startColor"
        static let endColor = "endColor"
        static let colorGraundName = "element"
        static let welcomeText = "Welcome back"
        static let hiText = "Hi"
        static let settingsName = "gearshape"
        static let unlockName = "lock.fill"
        static let lockName = "lock.open.fill"
        static let lockText = "Lock"
        static let unLockText = "Unlock"
        static let lockCarName = "lockCar"
        static let unlockCarName = "tsla"
        static let startUnlockColor = "startUnlock"
        static let darkUnlockColor = "darkUnlock"
        static let startlockColor = "startlockColor"
        static let endLockColor = "endLockColor"
        static let endUnlockColor = "enUnlockColor"
    }
    
    var body: some View {
        NavigationView {
            if isLoading {
                LoadView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
                            self.isLoading = false
                        }
                    }
            } else {
                backgroundStackView {
                    VStack {
                        settingsButton
                            .padding(.trailing, 15)
                        Spacer()
                        welcomeText
                        if isLock {
                            carUnlockImage
                            Spacer()
                                .frame(height: 59)
                        } else {
                            Spacer()
                                .frame(height: 63.04)
                            carLockImage
                        }
                        Spacer()
                        lockButton
                        Spacer()
                    }
                }
            }
        }
    }
    
    @State private var isLock = true
    @State private var isShowCar = false
    @State private var isLoading = true
    
    private var welcomeText: some View {
        VStack {
            Text(Constants.hiText)
                .font(.system(size: 17, weight: .semibold))
                .opacity(0.4)
            Text(Constants.welcomeText)
                .foregroundColor(.white)
                .font(.system(size: 38, weight: .bold))
        }.opacity(isLock ? 0 : 1)
    }
    
    private var carUnlockImage: some View {
        Image(Constants.unlockCarName)
            .resizable()
            .frame(width: 388.6, height: 330)
            
    }
    
    private var carLockImage: some View {
        Image(Constants.lockCarName)
            .resizable()
            .frame(width: 400, height: 350)
            .shadow(color: Color(Constants.startColor).opacity(0.25), radius: 50, x: 20, y: 0)
            .padding(.leading, 10)
    }
    
    private var settingsButton: some View {
        HStack {
            Spacer()
            NavigationLink {
                Tab()
            } label: {
                Image(systemName: Constants.settingsName)
                    .foregroundColor(.gray)
                    .frame(width: 35, height: 35)
                    .neumorphismStrokeSelectedCircleStyle()
            }
        }
    }
    
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.startColor), Color(Constants.endColor)], startPoint: .bottom, endPoint: .top)
    }
    
    
    private var darkGradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.startUnlockColor), Color(.black), Color(Constants.endUnlockColor)], startPoint: .top, endPoint: .bottom)
    }
    
    private var lightGradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.startlockColor), Color(Constants.endLockColor)], startPoint: .top, endPoint: .bottom)
    }
    
    private var lockButton: some View {
        Button {
            withAnimation(.linear(duration: 0.8)) {
                isLock.toggle()
                isShowCar.toggle()
            }
        } label: {
            HStack(spacing: 25) {
                Text(isLock ? Constants.unLockText : Constants.lockText)
                    .foregroundColor (.white)
                gradientImage
                .neumorphismStrokeSelectedCircleStyle()
            }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color (Constants.endLockColor))
                        .frame(width: 170)
                )
        }
    }
    
    private var gradientImage: some View {
        LinearGradient(
            colors: [Color(Constants.startColor), Color(Constants.endColor)], startPoint: .bottom, endPoint: .top)
        .mask(
            Image(systemName: isLock ? Constants.unlockName : Constants.lockName)
                .renderingMode(.template)
        )
        .shadow(color: Color(Constants.startColor).opacity(0.5), radius: 10, x: -5, y: -5)
        .shadow(color: Color(Constants.endColor).opacity(0.5), radius: 10, x: 5, y: 5)
        .frame(width: 30, height: 30)
    }
    
    private func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    isLock ? darkGradient : lightGradient
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct StartedView_Previews: PreviewProvider {
    static var previews: some View {
        StartedView()
            .environment (\.colorScheme, .dark)
    }
}
