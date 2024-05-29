import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(EquatableMacros)
import EquatableMacros

let testMacros: [String: Macro.Type] = [
    "Equatable": EquatableExtensionMacro.self,
]
#endif

final class EquatableTests: XCTestCase {
    func testEquatableMacroOnFinalClasses() throws {
        #if canImport(EquatableMacros)
        
        assertMacroExpansion(
            """
            @Equatable
            final class Planet {
                let name: String
                let mass: Mass
            
                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }
            """,
            expandedSource: """
            final class Planet {
                let name: String
                let mass: Mass

                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }

            extension Planet: Equatable {
                static func == (lhs: Planet, rhs: Planet) -> Bool {
                    lhs.name == rhs.name &&
                    lhs.mass == rhs.mass
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testEquatableMacroOnPublicFinalClasses() throws {
        #if canImport(EquatableMacros)
        
        assertMacroExpansion(
            """
            @Equatable
            public final class Planet {
                let name: String
                let mass: Mass
            
                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }
            """,
            expandedSource: """
            public final class Planet {
                let name: String
                let mass: Mass

                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }

            extension Planet: Equatable {
                public static func == (lhs: Planet, rhs: Planet) -> Bool {
                    lhs.name == rhs.name &&
                    lhs.mass == rhs.mass
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testEquatableMacroOnActors() throws {
        #if canImport(EquatableMacros)
        
        assertMacroExpansion(
            """
            @Equatable
            actor Planet {
                let name: String
                let mass: Mass
            
                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }
            """,
            expandedSource: """
            actor Planet {
                let name: String
                let mass: Mass

                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }

            extension Planet: Equatable {
                static func == (lhs: Planet, rhs: Planet) -> Bool {
                    lhs.name == rhs.name &&
                    lhs.mass == rhs.mass
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testEquatableMacroOnStructs() throws {
        #if canImport(EquatableMacros)
        
        assertMacroExpansion(
            """
            @Equatable
            struct Planet {
                let name: String
                let mass: Mass
            
                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }
            """,
            expandedSource: """
            struct Planet {
                let name: String
                let mass: Mass

                var this: String { "1" }
                
                init(name: String) {
                    self.name = name
                }
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@Equatable can only be applied to final class or actor", line: 1, column: 1)
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
