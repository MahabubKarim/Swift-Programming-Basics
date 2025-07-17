import Foundation

// Structures is value type, means you get the value if you using two reference
// they will get the same value not the reference of that value

/// Without Constructor
struct Person {
    let name: String
    let age: Int
}
let foo = Person(name: "Foo", age: 30)
foo.name
foo.age
let nameAndAge = "Name: " + foo.name + " And Age: " + "\(foo.age)"


struct CommodoreComputer {
    let name: String
    let manufacturer: String
}
let c64 = CommodoreComputer(
    name: "My Commodore 64",
    manufacturer: "Commodore"
)
let c128 = CommodoreComputer(
    name: "My Commodore 128",
    manufacturer: "Commodore"
)


/// With Constructor
struct CommodoreComputer2 {
    let name: String
    let manufacturer: String
    
    init(name: String) {
        self.name = name
        self.manufacturer = "Commodore"
    }
}
let c64_2 = CommodoreComputer2(
    name: "My Commodore 64"
)
let c128_2 = CommodoreComputer2(
    name: "My Commodore 128"
)


struct CommodoreComputer3 {
    let name: String
    let manufacturer = "Commodore"
}
let c64_3 = CommodoreComputer3(
    name: "My Commodore 64"
)
c64_3.name
c64_3.manufacturer


// Use Without Computed Property
struct Person2 {
    let firstName: String
    let lastName: String
    let fullName: String
    //Cannot use instance member 'firstName' within property initializer; property initializers run before 'self' is available
    // let fullName = "\(firstName) + \(lastName)"
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = "\(firstName) \(lastName)"
    }
}

// Use Computed Property
struct Person3 {
    let firstName: String
    let lastName: String
    // let fullName = "\(firstName) \(lastName)" // not working
    var fullName: String {
        "\(firstName) \(lastName)"  // Working
    }
}
let fooBar = Person2(
    firstName: "Foo",
    lastName: "Bar"
)
fooBar.fullName



// Structures don't allow immutibilty, they are inherently immutable
// make a function that can mutate a structure
struct Car {
    var currentSpeed: Int
    
    mutating func drive(speed: Int) {
        "Driving..."
        currentSpeed = speed
        
        // let currentSpeed: Int
        // Cannot assign to property: 'currentSpeed' is a 'let' constant
        
        // var currentSpeed: Int
        // Mark method 'mutating' to make 'self' mutable
    }
}

// Cannot use mutating member on immutable value: 'immutableCar' is a 'let' constant, change it to var
// let immutableCar = Car(currentSpeed: 10)
var immutableCar = Car(currentSpeed: 10)
immutableCar.drive(speed: 20)


var immutableCar2 = Car(currentSpeed: 10)
let copy = immutableCar2
immutableCar2.drive(speed: 30)
immutableCar2.currentSpeed
// because structure is not reference type, so the currentSpeed didn't change
copy.currentSpeed

// Cannot use mutating member on immutable value: 'copy' is a 'let' constant
// copy.drive(speed: 100)



// Subclasses, structure cannot inherit each other
struct LivingThing {
    init() {
        "I'm a living thing"
    }
}

//struct Animal: LivingThing { // Inheritance from non-protocol type 'LivingThing'
//    
//}


// Custom Copying
struct Bike {
    let manufacturer: String
    let currentSpeed: Int
    
    func copiedWith(currentSpeed : Int) -> Bike {
        Bike(
            manufacturer: self.manufacturer,
            currentSpeed: currentSpeed
        )
    }
}
let bike1 = Bike(
    manufacturer: "HD",
    currentSpeed: 20
)
let bike2 = bike1.copiedWith(currentSpeed: 50)
bike1.currentSpeed
bike2.currentSpeed
