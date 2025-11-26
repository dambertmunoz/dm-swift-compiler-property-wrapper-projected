//
//  ValidationRule.swift
//  PropertyWrapperKit
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Foundation

/// @author Dambert Muñoz
/// Validation rules for @Validated property wrapper
public enum ValidationRule: Sendable, Equatable {
    case notEmpty
    case email
    case minLength(Int)
    case maxLength(Int)
    case regex(String)
    
    public func validate(_ value: String) -> Bool {
        switch self {
        case .notEmpty:
            return !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case .email:
            let pattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
            return value.range(of: pattern, options: .regularExpression) != nil
        case .minLength(let min):
            return value.count >= min
        case .maxLength(let max):
            return value.count <= max
        case .regex(let pattern):
            return value.range(of: pattern, options: .regularExpression) != nil
        }
    }
    
    public var errorMessage: String {
        switch self {
        case .notEmpty: return "Field cannot be empty"
        case .email: return "Invalid email format"
        case .minLength(let min): return "Minimum \(min) characters required"
        case .maxLength(let max): return "Maximum \(max) characters allowed"
        case .regex: return "Invalid format"
        }
    }
    
    public static func == (lhs: ValidationRule, rhs: ValidationRule) -> Bool {
        switch (lhs, rhs) {
        case (.notEmpty, .notEmpty), (.email, .email): return true
        case (.minLength(let l), .minLength(let r)): return l == r
        case (.maxLength(let l), .maxLength(let r)): return l == r
        case (.regex(let l), .regex(let r)): return l == r
        default: return false
        }
    }
}
