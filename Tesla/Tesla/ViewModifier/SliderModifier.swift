//
//  SliderModifier.swift
//  Tesla
//
//  Created by Киса Мурлыса on 15.05.2024.
//

import SwiftUI

/// Модификатор слайдера

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(
                key: SizePreferenceKey.self,
                value: geometry.size
            )
        })
    }
}

/// Кастомный слайдер.
struct CarSettingsSlider<Value, Track, Fill, Thumb>: View
where Value: BinaryFloatingPoint,
      Value.Stride: BinaryFloatingPoint,
      Track: View,
      Fill: View,
      Thumb: View {
    
    let bounds: ClosedRange<Value>
    let step: Value
    let minimumValueLabel: Text?
    let maximumValueLabel: Text?
    let onEditingChanged: ((Bool) -> Void)?
    let trackClouser: () -> Track
    let fillClouser: (() -> Fill)?
    let thumbClouser: () -> Thumb
    let thumbSizeClouser: CGSize
    
    @Binding var value: Value
    
    @State private var xOffset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var trackSize: CGSize = .zero
    
    
    init(value: Binding<Value>,
         in bounds: ClosedRange<Value> = 0...1,
         step: Value = 0.001,
         minimumValueLabel: Text? = nil,
         maximumValueLabel: Text? = nil,
         onEditingChanged: ((Bool) -> Void)? = nil,
         track: @escaping () -> Track,
         fill: (() -> Fill)?,
         thumb: @escaping () -> Thumb,
         thumbSize: CGSize) {
        _value = value
        self.bounds = bounds
        self.step = step
        self.minimumValueLabel = minimumValueLabel
        self.maximumValueLabel = maximumValueLabel
        self.onEditingChanged = onEditingChanged
        self.trackClouser = track
        self.fillClouser = fill
        self.thumbClouser = thumb
        self.thumbSizeClouser = thumbSize
    }
    
    var body: some View {
        HStack {
            minimumValueLabel
            ZStack {
                trackView
                fillView
            }
            .frame(width: trackSize.width, height: trackSize.height)
            .overlay(
                thumbView,
                alignment: .leading
            )
            maximumValueLabel
        }
        .frame(height: max(trackSize.height, thumbSizeClouser.height))
    }
    
    private var percentage: Value {
        1 - (bounds.upperBound - value) / (bounds.upperBound - bounds.lowerBound)
    }
    
    private var fillWidth: CGFloat {
        trackSize.width * CGFloat(percentage)
    }
    
    private var fillView: some View {
        fillClouser?()
            .position(x: fillWidth - trackSize.width / 2, y: trackSize.height / 2)
            .frame(width: fillWidth, height: trackSize.height)
    }
    
    private var trackView: some View {
        trackClouser()
            .measureSize ()
    }
    
    private var thumbView: some View {
        thumbClouser()
            .position(
                x: thumbSizeClouser.width / 2,
                y: thumbSizeClouser.height / 2
            )
            .frame(width: thumbSizeClouser.width, height: thumbSizeClouser.height)
            .offset(x: xOffset)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged(
                        { gestureValue in
                            if abs(gestureValue.translation.width) < 0.1 {
                                lastOffset = xOffset
                                onEditingChanged?(true)
                            }
                            let availableWidth = trackSize.width - thumbSizeClouser.width
                            xOffset = max(0, min(lastOffset + gestureValue.translation.width, availableWidth))
                            let newValue = (bounds.upperBound - bounds.lowerBound) * Value(xOffset / availableWidth) + bounds.lowerBound
                            let steppedNewValue = (round(newValue / step) * step)
                            value = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
                        }).onEnded({ _ in
                            onEditingChanged?(false)
                        }))
    }
}

