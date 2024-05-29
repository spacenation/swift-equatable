import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public enum EquatableExtensionError: CustomStringConvertible, Error {
    case onlyApplicableToFinalClassOrActor
    
    public var description: String {
        switch self {
        case .onlyApplicableToFinalClassOrActor:
            "@Equatable can only be applied to final class or actor"
        }
    }
}

public enum EquatableExtensionMacro: ExtensionMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, attachedTo declaration: some SwiftSyntax.DeclGroupSyntax, providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol, conformingTo protocols: [SwiftSyntax.TypeSyntax], in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
                
        guard [.classDecl, .actorDecl].contains(declaration.kind) else {
            throw EquatableExtensionError.onlyApplicableToFinalClassOrActor
        }
        
        if case .classDecl = declaration.kind, !declaration.modifiers.contains(where: { $0.name.tokenKind == .keyword(.final) }) {
            throw EquatableExtensionError.onlyApplicableToFinalClassOrActor
        }
        
        let isPublic = declaration.modifiers.contains(where: { $0.name.tokenKind == .keyword(.public) })
        let addModifiers = isPublic ? "public " : ""
        
        return try [
            ExtensionDeclSyntax("extension \(type.trimmed): Equatable") {
                try FunctionDeclSyntax("\(raw: addModifiers)static func == (lhs: \(type.trimmed), rhs: \(type.trimmed)) -> Bool") {
                    let properties = declaration.memberBlock.members
                        .compactMap { $0.decl.as(VariableDeclSyntax.self) }
                        .compactMap { $0.bindings.first?.as(PatternBindingSyntax.self) }
                        .filter { $0.accessorBlock == nil }
                        .compactMap { $0.pattern.as(IdentifierPatternSyntax.self) }
                        .map { $0.identifier.text }
                    
                    for (index, property) in properties.enumerated() {
                        let addOperator = index == properties.indices.last ? "" : " &&"
                        "lhs.\(raw: property) == rhs.\(raw: property)\(raw: addOperator)"
                    }
                }
            }
        ]

    }
}

@main
struct EquatablePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        EquatableExtensionMacro.self,
    ]
}
