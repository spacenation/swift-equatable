/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@attached(extension, conformances: Equatable)
public macro equatable() = #externalMacro(module: "MacroExamplesImplementation", type: "EquatableExtensionMacro")
