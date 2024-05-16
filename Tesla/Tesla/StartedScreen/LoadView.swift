//
//  LoadView.swift
//  Tesla

import SwiftUI

struct LoadView: View {
    
    var body: some View {
        VStack {
            Text("Tesla")
                .font(.system(size: isLoad ? 50 : 0))
                .foregroundColor(Color.cyan)
                .bold()
            ZStack {
                LogoView()
                    .frame(height: 400)
                    .foregroundColor(.gray)
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
        }.padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.linear(duration: 3)) {
                        self.isLoad = true
                    }
                }
            }
    }
    
    private let gradient = LinearGradient(colors: [Color("startColor"), Color(.cyan)], startPoint: .top, endPoint: .bottom)
    
    @State private var progress = 0.0
    @State private var isLoad = false
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
            .environment (\.colorScheme, .dark)
    }
}
