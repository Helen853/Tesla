//
//  ClimateViewModel.swift
//  Tesla

import Foundation

/// ViewModel для экрана климата
final class ClimateViewModel: ObservableObject {
    
    @Published public var currentTemperature: Float = 15
    @Published public var showTemperature = false
    
    private let minCount: Float = 15
    private let maxCount: Float = 30
    
    /// Увеличение температуры
    func addTemperature() {
        guard currentTemperature == maxCount else { return currentTemperature += 1 }
        
    }
    
    /// Уменьшение температуры
    func reduceTemperature() {
        guard currentTemperature == minCount else { return currentTemperature -= 1 }
        
    }
    
    /// Обновление температуры
    /// - Parameters:
    /// - sliderValue: значение слайдера
    func updateTemperature(sliderValue: Float) {
        currentTemperature = sliderValue
    }
}
