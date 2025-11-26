# PropertyWrapperKit

[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9+-F05138.svg?style=flat&logo=swift)](https://swift.org)
[![iOS 17+](https://img.shields.io/badge/iOS-17.0+-007AFF.svg?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A Swift package that demonstrates advanced property wrapper patterns with projected values. This implementation shows how to build custom property wrappers that expose additional state through the `$` prefix syntax, similar to SwiftUI's `@State` and `@Published`.

## Overview

Property wrappers in Swift allow you to add custom behavior to property access. The **projected value** feature (`$propertyName`) enables exposing additional metadata or functionality beyond the wrapped value itself.

This package includes three production-ready property wrappers:

| Wrapper | Purpose | Projected Value |
|---------|---------|-----------------|
| `@Validated` | Input validation | Validation state, errors |
| `@UserDefault` | UserDefaults persistence | Reset, metadata |
| `@Clamped` | Range-constrained values | Range info, bounds |

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/dambertmunoz/dm-swift-compiler-property-wrapper-projected", from: "1.0.0")
]
```

## Understanding Projected Values

When you define a property wrapper, you can expose a `projectedValue` that becomes accessible via the `$` prefix:

```swift
@propertyWrapper
struct Validated {
    var wrappedValue: String        // Access: propertyName
    var projectedValue: State       // Access: $propertyName
}
```

This pattern is powerful because it separates the primary value from its metadata.

## @Validated

Real-time input validation with comprehensive error reporting.

### Basic Usage

```swift
class RegistrationViewModel {
    @Validated(rules: [.notEmpty, .email])
    var email = ""
    
    @Validated(rules: [.notEmpty, .minLength(8)])
    var password = ""
    
    var canSubmit: Bool {
        $email.isValid && $password.isValid
    }
}
```

### Accessing Validation State

```swift
let vm = RegistrationViewModel()
vm.email = "invalid"

// Check validity
print($vm.email.isValid)      // false

// Get all error messages
print($vm.email.errors)       // ["Invalid email format"]

// Get first error for display
print($vm.email.firstError)   // "Invalid email format"

// Check if user has interacted
print($vm.email.isDirty)      // true
```

### Available Rules

```swift
.notEmpty                    // Non-empty after trimming whitespace
.email                       // Standard email format
.minLength(8)               // Minimum character count
.maxLength(100)             // Maximum character count
.regex("[A-Z]{2}[0-9]{4}")  // Custom pattern matching
```

### Combining Multiple Rules

```swift
@Validated(rules: [
    .notEmpty,
    .minLength(8),
    .maxLength(50),
    .regex(".*[A-Z].*"),     // At least one uppercase
    .regex(".*[0-9].*")      // At least one digit
])
var securePassword = ""
```

## @UserDefault

Type-safe UserDefaults access with Codable support.

### Basic Usage

```swift
class Settings {
    @UserDefault(key: "app.theme", defaultValue: "light")
    var theme: String
    
    @UserDefault(key: "app.fontSize", defaultValue: 16)
    var fontSize: Int
    
    @UserDefault(key: "app.notifications", defaultValue: true)
    var notificationsEnabled: Bool
}
```

### Projected Value Features

```swift
let settings = Settings()

// Check the storage key
print($settings.theme.key)           // "app.theme"

// Get the default value
print($settings.theme.defaultValue)  // "light"

// Check if modified from default
print($settings.theme.isModified)    // false

// Reset to default
$settings.theme.reset()
```

### Custom UserDefaults Suite

```swift
let appGroup = UserDefaults(suiteName: "group.com.myapp")!

@UserDefault(key: "shared.data", defaultValue: [], userDefaults: appGroup)
var sharedItems: [String]
```

### Complex Types

```swift
struct UserPreferences: Codable {
    var language: String
    var region: String
}

@UserDefault(key: "user.preferences", defaultValue: UserPreferences(language: "en", region: "US"))
var preferences: UserPreferences
```

## @Clamped

Constrains numeric values to a specified range.

### Basic Usage

```swift
class AudioPlayer {
    @Clamped(min: 0, max: 100)
    var volume = 50
    
    @Clamped(min: 0.5, max: 2.0)
    var playbackRate = 1.0
}
```

### Automatic Clamping

```swift
let player = AudioPlayer()

player.volume = 150    // Stored as 100
player.volume = -20    // Stored as 0

print(player.volume)   // 100 or 0
```

### Projected Value Features

```swift
// Access the valid range
print($player.volume.range)       // 0...100

// Check boundary conditions
print($player.volume.isAtMin)     // false
print($player.volume.isAtMax)     // true

// Calculate percentage (for sliders)
let pct: Double = $player.volume.percentage()  // 1.0
```

### Works with Any Comparable Type

```swift
@Clamped(min: Date.distantPast, max: Date.now)
var birthDate = Date()

@Clamped(min: "A", max: "Z")
var grade = "C"
```

## Architecture

This package follows MVVM with Clean Architecture principles:

```
Sources/PropertyWrapperKit/
├── Domain/
│   └── Entities/           # ValidationRule, ValidationState
├── Core/
│   └── PropertyWrappers/   # Validated, UserDefault, Clamped
└── Presentation/
    └── ViewModels/         # Example ViewModels
```

## SwiftUI Integration

```swift
struct LoginView: View {
    @State private var email = ""
    @Validated(rules: [.notEmpty, .email]) 
    private var validatedEmail = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .onChange(of: email) { _, newValue in
                    validatedEmail = newValue
                }
            
            if !$validatedEmail.isValid && $validatedEmail.isDirty {
                Text($validatedEmail.firstError ?? "")
                    .foregroundColor(.red)
            }
        }
    }
}
```

## Testing

```bash
swift test
```

The package includes comprehensive tests for all property wrappers using Swift Testing framework.

## Requirements

- iOS 17.0+ / macOS 14.0+
- Swift 5.9+
- Xcode 15.0+

## Author

**Dambert Muñoz**  
Senior iOS Developer with 12+ years of experience building apps for the Apple ecosystem.

- [LinkedIn](https://www.linkedin.com/in/dambert-m-4b772397/)
- [GitHub](https://github.com/dambertmunoz)

## License

MIT License. See [LICENSE](LICENSE) for details.
