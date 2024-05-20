//
//  LoadView.swift
//  Tesla

import SwiftUI

struct LoadView: View {
    
    @State var isShow = [false, false, false, false, false, false]
    
    var body: some View {
        ZStack {
            Color("light")
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                   loadingView
                    Text("Tesla")
                        .font(.system(size: isLoad ? 35 : 0, weight: .bold))
                        .opacity(isLoad ? 1 : 0)
                        .foregroundColor(Color.cyan)
                    loadingView.rotationEffect(.degrees(-180))
                }
                ZStack {
                    LogoView()
                        .frame(height: 400)
                        .foregroundColor(Color("dark"))
                        .opacity(isLoad ? 1 : 0)
                    makeLogo()
                }
            }.padding()
       }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation(.linear(duration: 3)) {
                        self.isLoad = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.linear(duration: 0.5)) {
                        isShow[0] = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.linear(duration: 0.5)) {
                        isShow[1] = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.linear(duration: 0.5)) {
                        isShow[2] = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.linear(duration: 0.5)) {
                        isShow[3] = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.linear(duration: 0.5)) {
                        isShow[4] = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.linear(duration: 0.5)) {
                        isShow[5] = true
                    }
                }
            }
    }
    
    private let gradient = LinearGradient(colors: [Color("startColor"), Color(.cyan)], startPoint: .top, endPoint: .bottom)
    
    @State private var progress = 0.0
    @State private var isLoad = false
    
    private var loadingView: some View {
        HStack(spacing: 20) {
            ForEach(1..<isShow.count) { index in
                Capsule()
                    .fill(gradient)
                    .frame(width: 10, height: 60)
                    .opacity(isShow[index] ? 1 : 0)
                    .shadow(color: .cyan, radius: 50)
            }
        }
    }
    
    private func makeLogo() -> some View {
        Group {
            if isLoad {
                ZStack {
                    LogoView(progress: progress)
                        .trim(from: 0, to: progress)
                        .stroke(gradient, lineWidth: 8)
                        .shadow(color: Color("startColor"), radius: 30)
                        .frame(height: 400)
                        .animation(.easeOut(duration: 5.0), value: progress)
                        .onAppear {
                            self.progress = 1.0
                        }
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
            .environment (\.colorScheme, .dark)
    }
}
