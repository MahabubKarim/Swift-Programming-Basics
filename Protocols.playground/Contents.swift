import Foundation

// Protocols are special kind of object like java interfaces. dart mixins
// You create a set of rules that objects which conform to a protocol to follow
// Each classes or struct has at least 0 or more protocols

protocol CanBreate {
    func breathe()
}

// Structures don't allow inheretence
struct Animal: CanBreate {
    func breathe() {
        "Animal breathing..."
    }
}
struct Person: CanBreate {
    func breathe() {
        "Person Breathing..."
    }
}

let dog = Animal()
dog.breathe()
let person = Person()
person.breathe()


protocol CanJump {
    func jump()
}
extension CanJump {
    // Default implementation of jump function
    func jump() {
        "Jumping..."
    }
}

struct Cat: CanJump {
    // you can leave it without implementing the jump function because of extension CanJump
}
let cat = Cat()
cat.jump()


protocol HasName {
    // Protocols cannot require properties to be immutable; declare read-only properties by using 'var' with a '{ get }' specifier
    // let name: String
    var name: String {get}
    var age: Int {get set}
    mutating func increaseAge()
}
extension HasName {
    func describeMe() -> String {
        "Your name is \(name) and your age \(age) years old"
    }
    mutating func increaseAge() {
        self.age += 1
    }
}
struct Dog: HasName {
    let name: String
    var age: Int
}
var woof = Dog(
    name: "woof",
    age: 10
)
woof.name
woof.age
woof.age += 1
woof.age
woof.describeMe()
woof.increaseAge()
woof.age


// Mutating Function
protocol Vehicle {
    var speed: Int {get set}
    mutating func increaseSpeed(by value: Int)
}
extension Vehicle {
    mutating func increaseSpeed(by value: Int) {
        self.speed += value
    }
}
struct Bike: Vehicle {
    var speed: Int
    init() {
        self.speed = 0
    }
}
var bike = Bike()
bike.speed
bike.increaseSpeed(by: 120)
bike.speed

// is use in protocols to get the type and take decision
func describe(obj: Any) {
    if obj is Animal {
        "obj conforms to the Vehicle protocol"
    } else {
        "obj does NOT conform to the Vehicle protocol"
    }
}
describe(obj: Animal())
describe(obj: Dog(name: "Muezza", age: 2))


// using "as?" syntax you can conditinally promote a object to a specific type
func increaseSpeedIfVehicle(
    obj: Any
) {
    if var vehicle = obj as? Vehicle {
        vehicle.speed
        vehicle.increaseSpeed(by: 10)
        vehicle.speed
    } else {
        "This was not a Vehicle"
    }
}
increaseSpeedIfVehicle(obj: bike)
bike.speed // not 130 because struct value type so create a new object in memory, not take reference like classes
increaseSpeedIfVehicle(obj: dog)
