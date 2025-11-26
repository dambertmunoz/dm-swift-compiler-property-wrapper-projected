//
//  ExampleUsage.swift
//  PropertyWrapperKit
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import SwiftUI
import PropertyWrapperKit

// MARK: - Login Form Example

/// @author Dambert Muñoz
@Observable
final class LoginViewModel {
    @ObservationIgnored
    @Validated(rules: [.notEmpty, .email])
    var email = ""
    
    @ObservationIgnored
    @Validated(rules: [.notEmpty, .minLength(8)])
    var password = ""
    
    var canSubmit: Bool { $email.isValid && $password.isValid }
    var emailError: String? { $email.firstError }
    var passwordError: String? { $password.firstError }
}

// MARK: - Settings Example

/// @author Dambert Muñoz
final class SettingsManager {
    static let shared = SettingsManager()
    
    @UserDefault(key: "app.darkMode", defaultValue: false)
    var isDarkMode: Bool
    
    @UserDefault(key: "app.fontSize", defaultValue: 16)
    var fontSize: Int
}

// MARK: - Audio Player Example

/// @author Dambert Muñoz
@Observable
final class AudioPlayerViewModel {
    @ObservationIgnored
    @Clamped(min: 0, max: 100)
    var volume = 50
    
    var volumePercentage: Double { $volume.percentage() }
    var isMuted: Bool { $volume.isAtMin }
}
