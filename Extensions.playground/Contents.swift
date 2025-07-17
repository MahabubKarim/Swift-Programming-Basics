import Foundation

// Extension as name suggests, they can add funtionality to existing types. They can extend existing types.

extension Int {
    func plusTwo() -> Int {
        self
        return self + 2
    }
}
let two = 2
two.plusTwo()

// Using extensins, you can also add initializers to existing types (powerful feature of extension in swift)
struct Person {
    let firstName: String
    let lastName: String
}
extension Person {
    init(fullName: String) {
        let components = fullName.components(separatedBy: " ")
        self.init(
            firstName: components.first ?? fullName,
            lastName: components.last ?? fullName
        )
    }
}
let person = Person(fullName: "Foo Bar")
person.firstName
person.lastName


// You can also extend existing types and add protocol to an existing type
protocol GoesVroom {
    var vroomValue: String { get }
    func goVroom() -> String
}
extension GoesVroom {
    func goVroom() -> String {
        "\(self.vroomValue) goes vroom!"
    }
}
struct Car {
    let manufaturer: String
    let model: String
}
let modelX = Car(
    manufaturer: "Tesla",
    model: "X"
)
extension Car: GoesVroom {
    var vroomValue: String {
        "\(self.manufaturer) model \(self.model)"
    }
}
modelX.goVroom()


// Extension on Classes with convenience initializers to classes (structs don't have convinience initilizers)
class MyDouble {
    let value: Double
    init(value: Double) {
        self.value = value
    }
}
extension MyDouble {
    convenience init() {
        self.init(value: 0)
    }
}
MyDouble().value


// Extension extend Class, Structure but they can also extend protocols
extension GoesVroom {
    func goVroomVroomEvenMore() -> String {
        "\(self.vroomValue) is vrooming even more"
    }
}
modelX.goVroom()
modelX.goVroomVroomEvenMore()
