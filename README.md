# Swift Equatable Macro
![Swift Version](https://img.shields.io/badge/Swift-5.10-DE5D43)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)

This package automatically generates Equatable conformance for both classes and actors. This means that you do not need to manually implement the == operator for your classes and actors, as this package will handle it for you.

By conforming to Equatable, instances of your classes and actors can be easily compared for equality, which is useful for many operations such as sorting, searching, and maintaining collections. This package ensures that the generated == operator correctly compares all relevant properties of your classes and actors, providing a robust and efficient implementation.

Note: Classes must be marked as final to use this package. This ensures that the synthesized == operator is accurate and efficient, as it does not need to account for potential subclassing.

## Usage
Add `@Equatable` to class or actor annotations

```swift
import Example

@Equatable
public final class Planet {
    let name: String
    let mass: Mass
    
    public init(name: String) {
        self.name = name
    }
}

/// Expands to
extension Planet: Equatable {
    public static func == (lhs: Planet, rhs: Planet) -> Bool {
        lhs.name == rhs.name &&
        lhs.mass == rhs.mass
    }
}
```

## Installation
To use the `Example` library in a SwiftPM project, 
add it to the dependencies for your package and your target:

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/spacenation/swift-example", from: "1.0.0"),
    ],
    targets: [
        .target(
            // name, etc.
            dependencies: [
                // other dependencies
                .product(name: "Example", package: "swift-example")
            ]
        )
        // other targets
    ]
)
```

## Contributions
Feel free to contribute via fork/pull request to the main branch. If you want to request a feature or report a bug, please start a new issue.

## Become a Sponsor
If you find this project useful, please consider becoming our [GitHub Sponsor](https://github.com/sponsors/spacenation).
