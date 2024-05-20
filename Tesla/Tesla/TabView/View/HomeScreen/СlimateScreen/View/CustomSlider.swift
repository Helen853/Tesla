//
//  SliderModifier.swift
//  Tesla

import SwiftUI

struct CustomSlider: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 10)
                    .foregroundColor(.black)
                    .overlay {
                        Capsule()
                            .fill(LinearGradient(
                                stops: [
                                    .init(color: Color("dark"), location: 0.2),
                                    .init(color: Color("light"), location: 0.7)
                                ],
                                startPoint: .top,
                                endPoint: .bottom)
                            )
                            .padding(1)
                    }
                Capsule()
                    .frame(width: getSelectWidth(in: geometry), height: 10)
                    .foregroundStyle(color)
                Image(nameImage)
                    .frame(width: 27, height: 15)
                    .frame(width: thumbRadius, height: thumbRadius)
                    .offset(x: getPosition(in: geometry, of: thumbValue))
                    .gesture(
                        DragGesture(minimumDistance: 1)
                            .onChanged { value in
                                let newOffset = onDrag(value: value, geometry: geometry)
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    thumbValue = max(range.lowerBound, min(newOffset, range.upperBound))
                                }
                            }
                    )
            }
        }.frame(height: 15)
        .onAppear {
            thumbValue = min(range.upperBound, max(thumbValue, range.lowerBound))
        }
    }

    @Binding private var thumbValue: Float

    private let range: ClosedRange<Float>
    private let rangeLength: Float
    private let thumbRadius: CGFloat = 16
    private let color: Color
    private let nameImage: String

    init(firstValue: Binding<Float>, range: ClosedRange<Float>, color: Color, nameImage: String) {
        self.range = range
        rangeLength = range.upperBound - range.lowerBound
        _thumbValue = firstValue
        self.color = color
        self.nameImage = nameImage
    }

    private func getPosition(in geometry: GeometryProxy, of thumbValue: Float) -> CGFloat {
        let width = geometry.size.width - thumbRadius
        let position = width * CGFloat((thumbValue - range.lowerBound) / rangeLength)
        return position
    }

    private func onDrag(value: DragGesture.Value, geometry: GeometryProxy) -> Float {
        let width = geometry.size.width - thumbRadius
        let newValue = Float((value.location.x - thumbRadius / 2) / width) * rangeLength + range.lowerBound
        return newValue
    }

    private func getSelectWidth(in geometry: GeometryProxy) -> CGFloat {
        (geometry.size.width - thumbRadius) * CGFloat((thumbValue - range.lowerBound) / rangeLength)
    }
}
