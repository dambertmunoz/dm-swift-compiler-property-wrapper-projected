//
//  UserDefault.swift
//  PropertyWrapperKit
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Foundation

/// @author Dambert Muñoz
/// Property wrapper for UserDefaults with projected value
///
/// Usage:
/// ```swift
/// @UserDefault(key: "isDarkMode", defaultValue: false)
/// var isDarkMode: Bool
/// ```
@propertyWrapper
public struct UserDefault<Value: Codable> {
    private let key: String
    private let defaultValue: Value
    private let userDefaults: UserDefaults
    
    public var wrappedValue: Value {
        get {
            guard let data = userDefaults.data(forKey: key),
                  let decoded = try? JSONDecoder().decode(Value.self, from: data) else {
                return defaultValue
            }
            return decoded
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaults.set(data, forKey: key)
            }
        }
    }
    
    public var projectedValue: UserDefaultState<Value> {
        UserDefaultState(key: key, defaultValue: defaultValue, currentValue: wrappedValue, userDefaults: userDefaults)
    }
    
    public init(key: String, defaultValue: Value, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
}

/// @author Dambert Muñoz
public struct UserDefaultState<Value: Codable> {
    public let key: String
    public let defaultValue: Value
    public let currentValue: Value
    private let userDefaults: UserDefaults
    
    init(key: String, defaultValue: Value, currentValue: Value, userDefaults: UserDefaults) {
        self.key = key
        self.defaultValue = defaultValue
        self.currentValue = currentValue
        self.userDefaults = userDefaults
    }
    
    public var isModified: Bool {
        userDefaults.data(forKey: key) != nil
    }
    
    public func reset() {
        userDefaults.removeObject(forKey: key)
    }
}
