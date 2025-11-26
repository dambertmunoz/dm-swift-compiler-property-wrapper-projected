//
//  ValidationState.swift
//  PropertyWrapperKit
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Foundation

/// @author Dambert Muñoz
/// Validation state exposed via projected value ($)
public struct ValidationState: Sendable {
    public let isValid: Bool
    public let errors: [String]
    public let isDirty: Bool
    public let failedRules: [ValidationRule]
    
    public var hasErrors: Bool { !errors.isEmpty }
    public var firstError: String? { errors.first }
    
    public init(isValid: Bool, errors: [String] = [], isDirty: Bool = false, failedRules: [ValidationRule] = []) {
        self.isValid = isValid
        self.errors = errors
        self.isDirty = isDirty
        self.failedRules = failedRules
    }
    
    public static var valid: ValidationState {
        ValidationState(isValid: true)
    }
    
    public static func invalid(errors: [String], failedRules: [ValidationRule]) -> ValidationState {
        ValidationState(isValid: false, errors: errors, isDirty: true, failedRules: failedRules)
    }
}
