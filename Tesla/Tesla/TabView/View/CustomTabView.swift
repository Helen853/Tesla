//
//  CustomTabView.swift
//  Tesla

import SwiftUI

struct CustomTabView<Content: View>: View {
    @Binding var selection: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            TabBar()
                .fill(Color.black)
                .ignoresSafeArea(edges: .bottom)
                .overlay {
                    HStack(alignment: .bottom) {
                        tabsView
                    }.offset(y: 35)
                    .frame (maxWidth: .infinity)
                    .frame (height: 44)
                    .padding(.horizontal, 18)
                }
                .overlay(content: {
                    TabBar()
                        .stroke(Color("startRadial"), lineWidth: 1)
                        .blur(radius: 2)
                        .ignoresSafeArea(edges: .bottom)
                })
                .frame(height: 105)
        }
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            tabs = value
        }
    }
    
    @State private var tabs: [TabItem] = []
    
    private var content: Content
    
    private var tabsView: some View {
        ForEach(Array(tabs.enumerated()), id: \.offset) { index, element in
            Spacer()
            VStack(spacing: 5) {
                Image(element.icount)
                    .renderingMode(.template)
                    .frame(width: index == 1 ? 120 : 35, height: 44, alignment: .leading)
            }
            .foregroundColor(selection == index ? .cyan : .white)
            .background {
                ZStack {
                    if selection == index {
                        Circle()
                            .fill(LinearGradient(colors: [Color("endColor").opacity(0.7), Color("startColor").opacity(0.7)], startPoint: .bottom, endPoint: .top))
                            .frame(width: 40, height: 40)
                            .blur(radius: 20)
                            .offset(x: index == 1 ? -40 : 0)
                    }
                }
            }
            .onTapGesture {
                withAnimation {
                    selection = index
                }
            }
            Spacer()
        }
    }
    
    init(selection: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _selection = selection
    }
}
