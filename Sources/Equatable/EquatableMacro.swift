/// This macro allows you to easily generate the `==` operator for object types, reducing boilerplate code.
///
/// Here is how you can use the `Equatable` macro:
///
/// ```swift
/// @Equatable
/// final class MyClass {
///     var x: Int
///     var y: Int
/// }
///
/// let a = MyClass(x: 1, y: 2)
/// let b = MyClass(x: 1, y: 2)
///
/// // Now you can use the == operator
/// assert(a == b)
/// ```
@attached(extension, conformances: Equatable, names: named(==))
public macro Equatable() = #externalMacro(module: "EquatableMacros", type: "EquatableExtensionMacro")
