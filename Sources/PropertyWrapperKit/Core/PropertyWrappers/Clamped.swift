//
//  Clamped.swift
//  PropertyWrapperKit
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Foundation

/// @author Dambert Muñoz
/// Property wrapper that clamps values to a range
///
/// Usage:
/// ```swift
/// @Clamped(min: 0, max: 100)
/// var volume = 50
///
/// volume = 150 // Sets to 100
/// print($volume.range) // 0...100
/// ```
@propertyWrapper
public struct Clamped<Value: Comparable & Sendable>: Sendable {
    private var value: Value
    private let min: Value
    private let max: Value
    
    public var wrappedValue: Value {
        get { value }
        set { value = Swift.min(Swift.max(newValue, min), max) }
    }
    
    public var projectedValue: ClampedState<Value> {
        ClampedState(currentValue: value, min: min, max: max)
    }
    
    public init(wrappedValue: Value, min: Value, max: Value) {
        self.min = min
        self.max = max
        self.value = Swift.min(Swift.max(wrappedValue, min), max)
    }
}

/// @author Dambert Muñoz
public struct ClampedState<Value: Comparable & Sendable>: Sendable {
    public let currentValue: Value
    public let min: Value
    public let max: Value
    
    public var range: ClosedRange<Value> { min...max }
    public var isAtMin: Bool { currentValue == min }
    public var isAtMax: Bool { currentValue == max }
    
    public func percentage<F: BinaryFloatingPoint>() -> F where Value: BinaryInteger {
        let current = F(currentValue)
        let minVal = F(min)
        let maxVal = F(max)
        guard maxVal != minVal else { return 0 }
        return (current - minVal) / (maxVal - minVal)
    }
}
