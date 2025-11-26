# PropertyWrapperKit 🚀

[![Swift](https://img.shields.io/badge/Swift-5.9+-F05138.svg?style=flat&logo=swift)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-17.0+-007AFF.svg?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Author](https://img.shields.io/badge/Author-Dambert%20Muñoz-blue.svg)](https://github.com/dambertmunoz)

> **Dambert Muñoz** | Senior iOS Swift Developer | 12+ años de experiencia

## ⭐ Nivel: Expert (8+ años)

## 📖 Descripción

Implementación avanzada de **Custom Property Wrappers** con **Projected Values** (`$`) en Swift. Este paquete demuestra cómo crear property wrappers profesionales que exponen valores proyectados para bindings reactivos, similar a `@Published` y `@State`.

## ✨ Características

- ✅ `@Validated` - Validación en tiempo real con projected value
- ✅ `@UserDefault` - Persistencia con projected value para bindings
- ✅ `@Clamped` - Valores acotados a un rango
- ✅ Compatible con iOS 17+ y SwiftUI
- ✅ 100% Swift con arquitectura MVVM + Clean
- ✅ Incluye Tests completos
- ✅ Dependency Injection ready

## 🛠 Requisitos

| Requisito | Versión |
|-----------|--------|
| iOS | 17.0+ |
| Swift | 5.9+ |
| Xcode | 15.0+ |

## 📦 Instalación

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/dambertmunoz/dm-swift-compiler-property-wrapper-projected", from: "1.0.0")
]
```

## 🚀 Uso Rápido

### @Validated - Validación con Projected Value

```swift
import PropertyWrapperKit

class LoginViewModel {
    @Validated(rules: [.notEmpty, .email])
    var email: String = ""
    
    var isEmailValid: Bool { $email.isValid }
    var emailErrors: [String] { $email.errors }
}
```

### @UserDefault - Persistencia Reactiva

```swift
class SettingsViewModel {
    @UserDefault(key: "isDarkMode", defaultValue: false)
    var isDarkMode: Bool
    
    var darkModeBinding: Binding<Bool> { $isDarkMode.binding }
}
```

### @Clamped - Valores en Rango

```swift
class VolumeController {
    @Clamped(min: 0, max: 100)
    var volume: Int = 50
    
    var range: ClosedRange<Int> { $volume.range }
}
```

## 🏗️ Arquitectura

MVVM + Clean Architecture con SOLID Principles y Dependency Injection.

## 🧪 Tests

```bash
swift test
```

## 👨‍💻 Autor

**Dambert Muñoz**
- 🍎 Senior iOS Swift Developer | 12+ años
- 📧 dmsantillana2705@gmail.com
- 💼 [LinkedIn](https://linkedin.com/in/dambertmunoz)
- 🐙 [GitHub](https://github.com/dambertmunoz)

## 📄 Licencia

MIT License © 2025 Dambert Muñoz

---

⭐ **¿Te fue útil? ¡Dale una estrella!**

Happy coding! 🚀
