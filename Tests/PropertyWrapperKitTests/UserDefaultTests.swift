//
//  UserDefaultTests.swift
//  PropertyWrapperKitTests
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Testing
import Foundation
@testable import PropertyWrapperKit

/// @author Dambert Muñoz
@Suite("UserDefault Property Wrapper Tests")
struct UserDefaultTests {
    
    let testDefaults = UserDefaults(suiteName: "PropertyWrapperKitTests")!
    
    init() {
        testDefaults.removePersistentDomain(forName: "PropertyWrapperKitTests")
    }
    
    @Test("Returns default value when not set")
    func testDefaultValue() {
        @UserDefault(key: "testKey", defaultValue: "default", userDefaults: testDefaults)
        var value: String
        #expect(value == "default")
    }
    
    @Test("Persists value")
    func testPersistence() {
        @UserDefault(key: "boolKey", defaultValue: false, userDefaults: testDefaults)
        var flag: Bool
        flag = true
        #expect(flag == true)
    }
    
    @Test("Projected value exposes key")
    func testProjectedKey() {
        @UserDefault(key: "myKey", defaultValue: 0, userDefaults: testDefaults)
        var count: Int
        #expect($count.key == "myKey")
    }
    
    @Test("Reset restores default")
    func testReset() {
        @UserDefault(key: "resetKey", defaultValue: "original", userDefaults: testDefaults)
        var text: String
        text = "changed"
        $text.reset()
        
        @UserDefault(key: "resetKey", defaultValue: "original", userDefaults: testDefaults)
        var text2: String
        #expect(text2 == "original")
    }
}
