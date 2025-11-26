//
//  ValidatedTests.swift
//  PropertyWrapperKitTests
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Testing
@testable import PropertyWrapperKit

/// @author Dambert Muñoz
@Suite("Validated Property Wrapper Tests")
struct ValidatedTests {
    
    @Test("Empty string fails notEmpty")
    func testNotEmptyFails() {
        @Validated(rules: [.notEmpty])
        var field = ""
        #expect($field.isValid == false)
    }
    
    @Test("Non-empty string passes notEmpty")
    func testNotEmptyPasses() {
        @Validated(rules: [.notEmpty])
        var field = "Hello"
        #expect($field.isValid == true)
    }
    
    @Test("Valid email passes")
    func testValidEmail() {
        @Validated(rules: [.email])
        var email = "test@example.com"
        #expect($email.isValid == true)
    }
    
    @Test("Invalid email fails")
    func testInvalidEmail() {
        @Validated(rules: [.email])
        var email = "invalid"
        #expect($email.isValid == false)
    }
    
    @Test("MinLength validation")
    func testMinLength() {
        @Validated(rules: [.minLength(5)])
        var text = "Hi"
        #expect($text.isValid == false)
        
        text = "Hello"
        #expect($text.isValid == true)
    }
    
    @Test("Multiple rules")
    func testMultipleRules() {
        @Validated(rules: [.notEmpty, .email])
        var email = "test@example.com"
        #expect($email.isValid == true)
        #expect($email.errors.isEmpty)
    }
}
