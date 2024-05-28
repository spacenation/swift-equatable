import Equatable

@Equatable
final class Planet {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let planet1 = Planet(name: "Mars")
let planet2 = Planet(name: "Venus")

print("The value \(planet1 == planet2)")
