//
//  Validated.swift
//  PropertyWrapperKit
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Foundation

/// @author Dambert Muñoz
/// Property wrapper with real-time validation and projected value
///
/// Usage:
/// ```swift
/// @Validated(rules: [.notEmpty, .email])
/// var email = ""
///
/// if $email.isValid { print("Valid!") }
/// ```
@propertyWrapper
public struct Validated: Sendable {
    private var value: String
    private let rules: [ValidationRule]
    private var isDirty: Bool = false
    
    public var wrappedValue: String {
        get { value }
        set {
            value = newValue
            isDirty = true
        }
    }
    
    public var projectedValue: ValidationState {
        var errors: [String] = []
        var failedRules: [ValidationRule] = []
        
        for rule in rules {
            if !rule.validate(value) {
                errors.append(rule.errorMessage)
                failedRules.append(rule)
            }
        }
        
        return ValidationState(
            isValid: errors.isEmpty,
            errors: errors,
            isDirty: isDirty,
            failedRules: failedRules
        )
    }
    
    public init(wrappedValue: String = "", rules: [ValidationRule]) {
        self.value = wrappedValue
        self.rules = rules
    }
}
