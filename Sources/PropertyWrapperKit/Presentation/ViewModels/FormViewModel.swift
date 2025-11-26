//
//  FormViewModel.swift
//  PropertyWrapperKit
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Foundation
import SwiftUI

/// @author Dambert Muñoz
/// Example ViewModel with property wrappers - MVVM pattern
@Observable
@MainActor
public final class FormViewModel {
    
    @ObservationIgnored
    @Validated(rules: [.notEmpty, .email])
    public var email = ""
    
    @ObservationIgnored
    @Validated(rules: [.notEmpty, .minLength(8)])
    public var password = ""
    
    @ObservationIgnored
    @Clamped(min: 18, max: 120)
    public var age = 25
    
    @ObservationIgnored
    @UserDefault(key: "form.rememberMe", defaultValue: false)
    public var rememberMe: Bool
    
    public var isFormValid: Bool {
        $email.isValid && $password.isValid
    }
    
    public var allErrors: [String] {
        $email.errors + $password.errors
    }
    
    public init() {}
    
    public func validateForm() -> Bool {
        $email.isValid && $password.isValid
    }
    
    public func resetForm() {
        email = ""
        password = ""
        age = 25
    }
}
