//
//  ClampedTests.swift
//  PropertyWrapperKitTests
//
//  Created by Dambert Muñoz
//  © 2025 Dambert Muñoz. All rights reserved.
//

import Testing
@testable import PropertyWrapperKit

/// @author Dambert Muñoz
@Suite("Clamped Property Wrapper Tests")
struct ClampedTests {
    
    @Test("Value within range unchanged")
    func testWithinRange() {
        @Clamped(min: 0, max: 100)
        var volume = 50
        #expect(volume == 50)
    }
    
    @Test("Value above max clamped")
    func testClampToMax() {
        @Clamped(min: 0, max: 100)
        var volume = 50
        volume = 150
        #expect(volume == 100)
    }
    
    @Test("Value below min clamped")
    func testClampToMin() {
        @Clamped(min: 0, max: 100)
        var volume = 50
        volume = -50
        #expect(volume == 0)
    }
    
    @Test("Projected value range")
    func testRange() {
        @Clamped(min: 10, max: 90)
        var value = 50
        #expect($value.range == 10...90)
    }
    
    @Test("isAtMin and isAtMax")
    func testBoundaryFlags() {
        @Clamped(min: 0, max: 100)
        var value = 0
        #expect($value.isAtMin == true)
        
        value = 100
        #expect($value.isAtMax == true)
    }
}
